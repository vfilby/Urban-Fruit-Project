import type { PlantLocation } from '../types';

interface LocationDetailProps {
  location: PlantLocation;
  onClose: () => void;
}

function formatDate(dateStr: string): string {
  return new Date(dateStr).toLocaleDateString('en-CA', {
    year: 'numeric',
    month: 'long',
    day: 'numeric',
  });
}

function renderRating(rating: number | null) {
  if (rating === null) return <span className="rating-none">Not rated</span>;
  return (
    <span className="rating">
      {'★'.repeat(rating)}{'☆'.repeat(5 - rating)}
    </span>
  );
}

export default function LocationDetail({ location, onClose }: LocationDetailProps) {
  const sortedNotes = [...location.notes].sort(
    (a, b) => new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime()
  );

  return (
    <div className="location-detail">
      <div className="detail-header">
        <h2>{location.name}</h2>
        <button className="close-button" onClick={onClose} aria-label="Close">
          ×
        </button>
      </div>

      <div className="detail-body">
        <p className="detail-description">{location.description}</p>

        <div className="detail-meta">
          <div className="meta-item">
            <span className="meta-label">Location</span>
            <span>{location.location}</span>
          </div>
          <div className="meta-item">
            <span className="meta-label">Rating</span>
            {renderRating(location.rating)}
          </div>
          <div className="meta-item">
            <span className="meta-label">Coordinates</span>
            <span>{location.latitude.toFixed(5)}, {location.longitude.toFixed(5)}</span>
          </div>
          <div className="meta-item">
            <span className="meta-label">Added</span>
            <span>{formatDate(location.createdAt)}</span>
          </div>
          <div className="meta-item">
            <span className="meta-label">Contributor</span>
            <span>{location.contributorName}</span>
          </div>
        </div>

        {sortedNotes.length > 0 && (
          <div className="detail-notes">
            <h3>Notes ({sortedNotes.length})</h3>
            {sortedNotes.map((note) => (
              <div key={note.id} className="note-item">
                <p className="note-text">{note.text}</p>
                <span className="note-date">{formatDate(note.createdAt)}</span>
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  );
}
