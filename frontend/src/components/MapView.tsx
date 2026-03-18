import { useEffect } from 'react';
import { MapContainer, TileLayer, Marker, Popup, useMap } from 'react-leaflet';
import L from 'leaflet';
import type { PlantLocation } from '../types';

// Fix default marker icons (Leaflet + bundler issue)
import markerIcon2x from 'leaflet/dist/images/marker-icon-2x.png';
import markerIcon from 'leaflet/dist/images/marker-icon.png';
import markerShadow from 'leaflet/dist/images/marker-shadow.png';

delete (L.Icon.Default.prototype as unknown as Record<string, unknown>)._getIconUrl;
L.Icon.Default.mergeOptions({
  iconRetinaUrl: markerIcon2x,
  iconUrl: markerIcon,
  shadowUrl: markerShadow,
});

const SPECIES_COLORS: Record<string, string> = {
  apple: '#e74c3c',
  pear: '#f39c12',
  cherry: '#c0392b',
  raspberry: '#e91e63',
  walnut: '#795548',
  grape: '#9b59b6',
  plum: '#8e44ad',
  chestnut: '#6d4c41',
  crab: '#ff5722',
  other: '#2ecc71',
};

function getSpeciesCategory(name: string): string {
  const lower = name.toLowerCase();
  for (const key of Object.keys(SPECIES_COLORS)) {
    if (lower.includes(key)) return key;
  }
  return 'other';
}

function createColoredIcon(color: string): L.DivIcon {
  return L.divIcon({
    className: 'custom-marker',
    html: `<div style="
      background-color: ${color};
      width: 24px;
      height: 24px;
      border-radius: 50% 50% 50% 0;
      transform: rotate(-45deg);
      border: 2px solid white;
      box-shadow: 0 1px 4px rgba(0,0,0,0.3);
    "></div>`,
    iconSize: [24, 24],
    iconAnchor: [12, 24],
    popupAnchor: [0, -24],
  });
}

function BoundsUpdater({ onBoundsChange }: { onBoundsChange: (bounds: L.LatLngBounds) => void }) {
  const map = useMap();

  useEffect(() => {
    const handler = () => onBoundsChange(map.getBounds());
    map.on('moveend', handler);
    map.on('zoomend', handler);
    // Fire initial bounds
    onBoundsChange(map.getBounds());
    return () => {
      map.off('moveend', handler);
      map.off('zoomend', handler);
    };
  }, [map, onBoundsChange]);

  return null;
}

interface MapViewProps {
  locations: PlantLocation[];
  onSelectLocation: (location: PlantLocation) => void;
  onBoundsChange: (bounds: L.LatLngBounds) => void;
}

export default function MapView({ locations, onSelectLocation, onBoundsChange }: MapViewProps) {
  // Center on Ontario area where most data is
  const center: [number, number] = [43.45, -79.75];

  return (
    <MapContainer center={center} zoom={11} className="map-container">
      <TileLayer
        attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
        url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
      />
      <BoundsUpdater onBoundsChange={onBoundsChange} />
      {locations.map((loc) => {
        const category = getSpeciesCategory(loc.name);
        const color = SPECIES_COLORS[category];
        return (
          <Marker
            key={loc.id}
            position={[loc.latitude, loc.longitude]}
            icon={createColoredIcon(color)}
          >
            <Popup>
              <div className="popup-content">
                <strong>{loc.name}</strong>
                <p>{loc.description}</p>
                <p className="popup-location">{loc.location}</p>
                <button
                  className="popup-detail-link"
                  onClick={() => onSelectLocation(loc)}
                >
                  View Details
                </button>
              </div>
            </Popup>
          </Marker>
        );
      })}
    </MapContainer>
  );
}
