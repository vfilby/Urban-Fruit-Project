# User Stories & Acceptance Criteria

## 1. Account Management

### US-1.1: Register an account

**As a** visitor,
**I want to** create an account with email and password,
**so that** I can contribute plant locations and notes.

**Acceptance Criteria:**
- [ ] User provides email, password, and display name
- [ ] Email must be unique (case-insensitive)
- [ ] Password must be at least 8 characters
- [ ] Password is stored as a secure hash (bcrypt or argon2), never plaintext
- [ ] User receives confirmation and is logged in after registration
- [ ] Display name is shown publicly; email is private

### US-1.2: Log in / Log out

**As a** registered user,
**I want to** log in with my email and password,
**so that** I can access my account.

**Acceptance Criteria:**
- [ ] User can log in with email + password
- [ ] Failed login shows generic error (no user enumeration)
- [ ] Session persists across page reloads (JWT or secure cookie)
- [ ] User can log out, which invalidates the session

### US-1.3: View and edit profile

**As a** registered user,
**I want to** view and update my display name and email,
**so that** my public identity stays current.

**Acceptance Criteria:**
- [ ] User can view their profile
- [ ] User can change display name
- [ ] User can change email (re-verification deferred to post-V1)
- [ ] User can change password (requires current password)

---

## 2. Plant Locations

### US-2.1: Add a plant location

**As a** logged-in user,
**I want to** add a new plant location by placing a pin on the map,
**so that** others can find and harvest from this plant.

**Acceptance Criteria:**
- [ ] User can place a marker on the map or enter lat/lng manually
- [ ] User can use device GPS ("use my location") to set coordinates
- [ ] User provides a name (required) and description (optional)
- [ ] User can select a species from existing list or leave as "unknown"
- [ ] Location is saved with status `unverified`
- [ ] Location immediately appears on the map

### US-2.2: View a plant location

**As a** visitor (no login required),
**I want to** view details of a plant location,
**so that** I can decide whether to visit it.

**Acceptance Criteria:**
- [ ] Shows name, description, species, status
- [ ] Shows location on a map
- [ ] Shows all associated photos
- [ ] Shows all associated notes (newest first)
- [ ] Shows who added it and when
- [ ] Accessible via direct URL (shareable)

### US-2.3: Edit a plant location

**As a** logged-in user,
**I want to** edit a plant location I created,
**so that** I can correct mistakes or add details.

**Acceptance Criteria:**
- [ ] Creator can edit name, description, species, status, and coordinates
- [ ] Non-creators cannot edit (moderation is post-V1)
- [ ] Edit history is not tracked in V1 (future feature)

### US-2.4: Browse the map

**As a** visitor,
**I want to** see plant locations on an interactive map,
**so that** I can explore what's near me.

**Acceptance Criteria:**
- [ ] Map loads centered on user's location (with permission) or a default location
- [ ] Plant locations shown as markers, clustered when zoomed out
- [ ] Clicking a marker shows a summary popup with link to full details
- [ ] Map is the primary landing page experience
- [ ] Markers are color-coded or icon-coded by species category
- [ ] `gone` locations are visually distinct (grayed out or hidden by default)

---

## 3. Photos

### US-3.1: Upload photos

**As a** logged-in user,
**I want to** upload photos of a plant location,
**so that** others can see what the plant looks like.

**Acceptance Criteria:**
- [ ] User can upload one or more photos to an existing plant location
- [ ] Accepted formats: JPEG, PNG, WebP
- [ ] Photos are resized/compressed server-side (max 2048px longest edge)
- [ ] Thumbnails are generated
- [ ] User can add an optional caption
- [ ] Photos stored in S3
- [ ] Works from mobile camera (capture attribute)

### US-3.2: View photos

**As a** visitor,
**I want to** view photos of a plant location,
**so that** I can identify the plant and assess its condition.

**Acceptance Criteria:**
- [ ] Photos shown as a gallery on the location detail page
- [ ] Thumbnails load first, full-size on click/tap
- [ ] Caption displayed below each photo
- [ ] Photographer attribution shown

---

## 4. Notes

### US-4.1: Add a note

**As a** logged-in user,
**I want to** add a note to a plant location,
**so that** I can share observations (ripeness, condition, harvest tips).

**Acceptance Criteria:**
- [ ] User can write a text note on any plant location
- [ ] Notes are plain text (no rich formatting in V1)
- [ ] Note is attributed to the author with timestamp
- [ ] Notes appear reverse-chronologically on the location page

### US-4.2: View notes

**As a** visitor,
**I want to** read notes on a plant location,
**so that** I can learn from others' observations.

**Acceptance Criteria:**
- [ ] All notes are visible without login
- [ ] Shows author display name and date
- [ ] Newest notes first

---

## 5. Search & Discovery

### US-5.1: Search by species

**As a** visitor,
**I want to** search for a specific species,
**so that** I can find all locations of that plant type.

**Acceptance Criteria:**
- [ ] Text search matches species common name and scientific name
- [ ] Results shown on map and as a list
- [ ] Results can be filtered to current map viewport

### US-5.2: Search by area

**As a** visitor,
**I want to** search for plants near a specific location,
**so that** I can find what's harvestable near me or a destination.

**Acceptance Criteria:**
- [ ] User can search by city/address (geocoded to coordinates)
- [ ] Results show plants within a configurable radius
- [ ] Default radius is reasonable (e.g., 5km)

---

## 6. PWA / Offline

### US-6.1: Install as app

**As a** mobile user,
**I want to** install the site as an app on my home screen,
**so that** it feels native and is easily accessible.

**Acceptance Criteria:**
- [ ] Site serves a valid web app manifest
- [ ] Service worker enables basic caching
- [ ] "Add to Home Screen" prompt works on Android/iOS

### US-6.2: Offline data entry

**As a** user in the field,
**I want to** add a plant location even without cell service,
**so that** I don't lose the data when I'm in a park or trail.

**Acceptance Criteria:**
- [ ] User can fill out the "add location" form offline
- [ ] GPS coordinates are captured from device while offline
- [ ] Photos can be selected/captured offline
- [ ] Data is queued locally and synced when connectivity returns
- [ ] User sees clear indication of pending sync items
