export interface PlantLocation {
  id: number;
  name: string;
  description: string | null;
  latitude: number;
  longitude: number;
  location: string | null;
  species: string | null;
  status: "active" | "gone" | "seasonal" | "unverified";
  rating: number | null;
  contributorName: string;
  createdAt: string;
  notes: Note[];
  photos: Photo[];
}

export interface Note {
  id: number;
  body: string;
  authorName: string;
  createdAt: string;
}

export interface Photo {
  id: number;
  caption: string | null;
  url: string;
  thumbnailUrl: string;
}
