export interface Note {
  id: number;
  text: string;
  createdAt: string;
  userId: number;
}

export interface Photo {
  id: number;
  caption: string | null;
  url: string;
  thumbnailUrl: string;
}

export interface PlantLocation {
  id: number;
  name: string;
  description: string;
  latitude: number;
  longitude: number;
  location: string;
  rating: number | null;
  createdAt: string;
  updatedAt: string;
  contributorName: string;
  notes: Note[];
  photos: Photo[];
}
