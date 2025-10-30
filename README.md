# ERD Authentication flow


```mermaid
erDiagram
    
    USERS {
        int id PK
        string email UK 
        string password_hash 
        boolean is_email_verified 
        datetime created_at
        datetime updated_at
    }
    
    PROFILE {
        int users_id FK
        string username UK 
        string first_name
        string last_name
        string phone_number
    }
    
    EMAIL_VERIFICATION_TOKENS {
        int id PK
        int user_id FK
        string token UK 
        boolean is_used
        datetime created_at
        datetime used_at
    }
    
    PASSWORD_RESET_TOKENS {
        int id PK
        int user_id FK
        string token UK 
        boolean is_used
        datetime created_at
        datetime used_at
    }
    
    LOGIN_SESSIONS {
        int id PK
        int user_id FK
        string session_token UK 
        string refresh_token
        datetime created_at
        datetime last_activity
    }
    
    LOGIN_ATTEMPTS {
        int id PK
        int user_id FK 
        string email_or_username
        boolean is_successful
        datetime attempted_at
    }

    USERS ||--|| PROFILE : "has"
    USERS ||--o{ EMAIL_VERIFICATION_TOKENS : "has"
    USERS ||--o{ PASSWORD_RESET_TOKENS : "requests"
    USERS ||--o{ LOGIN_SESSIONS : "has"
    USERS ||--o{ LOGIN_ATTEMPTS : "tracks"