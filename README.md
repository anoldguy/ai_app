# Player Management App

A Ruby on Rails application for managing players with names, ages, and photos.

## Features

- **User Authentication**: Secure login/logout with Rails 8 Authentication
- **Inline Editing**: Turbo Frames for seamless inline player editing
- Create, read, update, and delete players (requires login)
- Upload and display player photos using Active Storage
- Responsive Bootstrap UI with real-time updates
- Form validations and error handling
- Age-based player categorization (adult/minor)

## Player Model

Each player has the following attributes:
- **Name**: Required, 2-50 characters
- **Birthdate**: Required, cannot be in the future or more than 120 years ago
- **Photo**: Optional image upload (JPEG, PNG, GIF, max 5MB)

### Model Methods

- `age` - Calculates current age from birthdate
- `adult?` - Returns true if player is 18 or older
- `display_age` - Returns formatted age string
- Scopes: `adults`, `by_age`, `by_name`

## Setup Instructions

### Ruby version
- Ruby 3.3+ (check `.ruby-version` file)

### System dependencies
- Rails 8.0+
- SQLite3
- ImageMagick (for image processing)

### Database setup
```bash
rails db:migrate
rails db:seed  # Creates sample players and test user
```

### How to run
```bash
rails server
```
Visit `http://localhost:3000` to access the application.

### Test User Account
- Email: `test@example.com`
- Password: `password`

### Running tests
```bash
rails test
```

## Usage

### Authentication
1. **Sign Up**: Create a new account with email and password
2. **Log In**: Use existing credentials to access the system
3. **Password Reset**: Use "Forgot password?" link if needed
4. **Log Out**: Click "Log Out" in the navigation when done

### Creating Players (Login Required)
1. Log in to your account
2. Click "Add New Player" card on the players page for inline creation
3. Fill in name and birthdate (required) directly in the card
4. Optionally upload a photo
5. Click "Create Player" - new player appears instantly

### Managing Players (Login Required)
- View all players on the players page in a responsive card grid
- Click "View" to see detailed player information
- Click "Edit" for **inline editing** - form appears in place of the card
- Click "Delete" to remove a player (with confirmation) - card disappears instantly
- All changes happen seamlessly without page reloads using Turbo Frames

### Age Calculation
- Ages are calculated dynamically from birthdates
- Always accurate regardless of when data was entered
- Players are automatically categorized as adults (18+) or minors

### Inline Editing (Turbo Frames)
- **Real-time editing**: Edit players directly on the index page
- **No page reloads**: All interactions use Turbo Frames and Streams
- **Instant feedback**: Success/error messages appear without navigation
- **Seamless UX**: Forms appear inline, maintaining page context
- **Live updates**: Changes appear immediately across the interface

### Photo Management
- Photos are stored using Active Storage
- Supported formats: JPEG, PNG, GIF
- Maximum file size: 5MB
- Photos are automatically resized for display

## File Structure

### Models
- `app/models/player.rb` - Player model with validations and methods

### Controllers
- `app/controllers/players_controller.rb` - RESTful player operations (requires authentication)
- `app/controllers/sessions_controller.rb` - User login/logout
- `app/controllers/registrations_controller.rb` - User registration
- `app/controllers/passwords_controller.rb` - Password reset functionality

### Views
- `app/views/players/index.html.erb` - Player listing with Turbo Frame cards
- `app/views/players/show.html.erb` - Individual player details
- `app/views/players/new.html.erb` - New player form
- `app/views/players/edit.html.erb` - Edit player form
- `app/views/players/_player_card.html.erb` - Reusable player card partial
- `app/views/players/_edit_form.html.erb` - Inline edit form partial
- `app/views/players/_new_form.html.erb` - Inline new player form partial
- `app/views/sessions/new.html.erb` - Login form
- `app/views/registrations/new.html.erb` - Registration form
- `app/views/passwords/new.html.erb` - Password reset form
- `app/views/shared/_flash.html.erb` - Flash messages for Turbo updates

### Database
- Migration: `db/migrate/*_create_players.rb`
- Migration: `db/migrate/*_create_users.rb` - User authentication
- Migration: `db/migrate/*_create_sessions.rb` - User sessions
- Active Storage tables for photo attachments

## Security Features

- **Rails 8 Authentication**: Modern built-in authentication system
- **Password Security**: BCrypt password hashing
- **Session Management**: Secure session handling with signed cookies
- **Route Protection**: All player operations require authentication
- **Rate Limiting**: Login attempts are rate-limited
- **CSRF Protection**: Built-in Rails CSRF protection

## Technical Features

- **Turbo Frames**: Seamless inline editing without page reloads
- **Turbo Streams**: Real-time UI updates for create/update/delete operations
- **Rails 8**: Latest Rails framework with modern patterns
- **Bootstrap 5**: Responsive design with custom CSS enhancements
- **Active Storage**: File upload handling with image processing
- **RESTful API**: Standard Rails controller patterns with Turbo enhancements
