import { useState, useCallback, useMemo } from 'react';
import L from 'leaflet';
import 'leaflet/dist/leaflet.css';
import './App.css';
import MapView from './components/MapView';
import LocationDetail from './components/LocationDetail';
import SearchBar from './components/SearchBar';
import locationsData from './data/locations.json';
import type { PlantLocation } from './types';

const allLocations = locationsData as PlantLocation[];

function App() {
  const [searchTerm, setSearchTerm] = useState('');
  const [selectedLocation, setSelectedLocation] = useState<PlantLocation | null>(null);
  const [mapBounds, setMapBounds] = useState<L.LatLngBounds | null>(null);

  const handleBoundsChange = useCallback((bounds: L.LatLngBounds) => {
    setMapBounds(bounds);
  }, []);

  const filteredLocations = useMemo(() => {
    let filtered = allLocations;

    if (searchTerm) {
      const term = searchTerm.toLowerCase();
      filtered = filtered.filter(
        (loc) =>
          loc.name.toLowerCase().includes(term) ||
          loc.description.toLowerCase().includes(term)
      );
    }

    if (mapBounds) {
      filtered = filtered.filter((loc) =>
        mapBounds.contains([loc.latitude, loc.longitude])
      );
    }

    return filtered;
  }, [searchTerm, mapBounds]);

  return (
    <div className="app">
      <header className="app-header">
        <h1>Urban Fruit Project</h1>
        <SearchBar
          searchTerm={searchTerm}
          onSearchChange={setSearchTerm}
          resultCount={filteredLocations.length}
          totalCount={allLocations.length}
        />
      </header>

      <main className="app-main">
        <MapView
          locations={filteredLocations}
          onSelectLocation={setSelectedLocation}
          onBoundsChange={handleBoundsChange}
        />

        {selectedLocation && (
          <LocationDetail
            location={selectedLocation}
            onClose={() => setSelectedLocation(null)}
          />
        )}
      </main>
    </div>
  );
}

export default App;
