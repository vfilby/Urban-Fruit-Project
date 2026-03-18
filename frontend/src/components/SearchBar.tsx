interface SearchBarProps {
  searchTerm: string;
  onSearchChange: (term: string) => void;
  resultCount: number;
  totalCount: number;
}

export default function SearchBar({ searchTerm, onSearchChange, resultCount, totalCount }: SearchBarProps) {
  return (
    <div className="search-bar">
      <input
        type="text"
        placeholder="Search by species name..."
        value={searchTerm}
        onChange={(e) => onSearchChange(e.target.value)}
        className="search-input"
      />
      {searchTerm && (
        <span className="search-count">
          {resultCount} of {totalCount} locations
        </span>
      )}
    </div>
  );
}
