# SkillHands API Documentation

Complete API reference for the SkillHands service marketplace platform.

## 📋 Table of Contents

- [Authentication](#authentication)
- [Users](#users)
- [Professionals](#professionals)
- [Bookings](#bookings)
- [Payments](#payments)
- [Reviews](#reviews)
- [Messages](#messages)
- [Admin](#admin)
- [Analytics](#analytics)
- [File Uploads](#file-uploads)
- [WebSocket](#websocket)
- [Error Handling](#error-handling)

## 🔐 Authentication

All API endpoints require authentication unless specified as public. Authentication is handled via session-based authentication with Replit Auth.

### Authentication Headers

```http
Authorization: Bearer <session_token>
```

### Public Endpoints

- `GET /api/categories` - Get service categories
- `GET /api/professionals/featured` - Get featured professionals
- `GET /api/professionals/search` - Search professionals
- `GET /api/professionals/:id` - Get professional profile

## 👥 Users

### Get Current User

```http
GET /api/auth/user
Authorization: Bearer <token>
```

**Response:**

```json
{
  "id": "user_123",
  "email": "user@example.com",
  "firstName": "John",
  "lastName": "Doe",
  "phone": "+1876-555-0123",
  "isProfessional": false,
  "isVerified": true,
  "profileImageUrl": "https://example.com/avatar.jpg",
  "createdAt": "2024-01-15T10:30:00Z",
  "updatedAt": "2024-01-20T14:45:00Z"
}
```

### Logout User

```http
POST /api/auth/logout
Authorization: Bearer <token>
```

**Response:**

```json
{
  "message": "Logged out successfully"
}
```

## 🏢 Professionals

### Get Featured Professionals

```http
GET /api/professionals/featured?limit=6
```

**Query Parameters:**

- `limit` (optional): Number of professionals to return (default: 6)

**Response:**

```json
[
  {
    "id": "pro_123",
    "userId": "user_456",
    "categoryId": "cat_789",
    "title": "Expert Plumber",
    "description": "Professional plumbing services with 10+ years experience",
    "hourlyRate": 2500,
    "currency": "JMD",
    "isAvailable": true,
    "isVerified": true,
    "rating": 4.8,
    "reviewCount": 45,
    "user": {
      "firstName": "Mike",
      "lastName": "Johnson",
      "profileImageUrl": "https://example.com/mike.jpg"
    },
    "category": {
      "name": "Plumbing",
      "icon": "🔧"
    }
  }
]
```

### Search Professionals

```http
GET /api/professionals/search?query=plumber&location=Kingston&categoryId=cat_789
```

**Query Parameters:**

- `query` (optional): Search term for professional title/description
- `location` (optional): Location to search in
- `categoryId` (optional): Filter by service category

**Response:**

```json
{
  "professionals": [
    {
      "id": "pro_123",
      "title": "Expert Plumber",
      "description": "Professional plumbing services",
      "hourlyRate": 2500,
      "currency": "JMD",
      "rating": 4.8,
      "reviewCount": 45,
      "user": {
        "firstName": "Mike",
        "lastName": "Johnson"
      }
    }
  ],
  "total": 1,
  "page": 1,
  "limit": 10
}
```

### Get Professional Profile

```http
GET /api/professionals/:id
```

**Response:**

```json
{
  "id": "pro_123",
  "userId": "user_456",
  "categoryId": "cat_789",
  "title": "Expert Plumber",
  "description": "Professional plumbing services with 10+ years experience",
  "hourlyRate": 2500,
  "currency": "JMD",
  "isAvailable": true,
  "isVerified": true,
  "rating": 4.8,
  "reviewCount": 45,
  "portfolio": [
    {
      "id": "port_1",
      "title": "Kitchen Renovation",
      "description": "Complete kitchen plumbing renovation",
      "imageUrl": "https://example.com/kitchen.jpg"
    }
  ],
  "reviews": [
    {
      "id": "rev_1",
      "rating": 5,
      "comment": "Excellent work, very professional",
      "createdAt": "2024-01-15T10:30:00Z",
      "user": {
        "firstName": "Sarah",
        "lastName": "Wilson"
      }
    }
  ],
  "user": {
    "firstName": "Mike",
    "lastName": "Johnson",
    "email": "mike@example.com",
    "phone": "+1876-555-0123",
    "profileImageUrl": "https://example.com/mike.jpg"
  },
  "category": {
    "name": "Plumbing",
    "icon": "🔧"
  }
}
```

### Create Professional Profile

```http
POST /api/professionals
Authorization: Bearer <token>
Content-Type: application/json

{
  "categoryId": "cat_789",
  "title": "Expert Plumber",
  "description": "Professional plumbing services with 10+ years experience",
  "hourlyRate": 2500,
  "currency": "JMD",
  "isAvailable": true
}
```

**Response:**

```json
{
  "id": "pro_123",
  "userId": "user_456",
  "categoryId": "cat_789",
  "title": "Expert Plumber",
  "description": "Professional plumbing services with 10+ years experience",
  "hourlyRate": 2500,
  "currency": "JMD",
  "isAvailable": true,
  "isVerified": false,
  "rating": 0,
  "reviewCount": 0,
  "createdAt": "2024-01-15T10:30:00Z"
}
```

## 📅 Bookings

### Create Booking

```http
POST /api/bookings
Authorization: Bearer <token>
Content-Type: application/json

{
  "professionalId": "pro_123",
  "serviceDate": "2024-02-15T14:00:00Z",
  "duration": 2,
  "description": "Fix leaking kitchen sink",
  "address": "123 Main Street, Kingston",
  "notes": "Please bring replacement parts"
}
```

**Response:**

```json
{
  "id": "booking_123",
  "clientId": "user_456",
  "professionalId": "pro_123",
  "serviceDate": "2024-02-15T14:00:00Z",
  "duration": 2,
  "description": "Fix leaking kitchen sink",
  "address": "123 Main Street, Kingston",
  "notes": "Please bring replacement parts",
  "status": "pending",
  "totalAmount": 5000,
  "currency": "JMD",
  "createdAt": "2024-01-15T10:30:00Z"
}
```

### Get User Bookings

```http
GET /api/bookings
Authorization: Bearer <token>
```

**Response:**

```json
[
  {
    "id": "booking_123",
    "professionalId": "pro_123",
    "serviceDate": "2024-02-15T14:00:00Z",
    "duration": 2,
    "description": "Fix leaking kitchen sink",
    "status": "pending",
    "totalAmount": 5000,
    "currency": "JMD",
    "professional": {
      "title": "Expert Plumber",
      "user": {
        "firstName": "Mike",
        "lastName": "Johnson"
      }
    }
  }
]
```

### Update Booking

```http
PUT /api/bookings/:id
Authorization: Bearer <token>
Content-Type: application/json

{
  "serviceDate": "2024-02-16T14:00:00Z",
  "notes": "Updated notes"
}
```

### Cancel Booking

```http
DELETE /api/bookings/:id
Authorization: Bearer <token>
```

## 💳 Payments

### Process Payment

```http
POST /api/payments
Authorization: Bearer <token>
Content-Type: application/json

{
  "bookingId": "booking_123",
  "gateway": "First Atlantic Commerce",
  "amount": 5000,
  "currency": "JMD"
}
```

**Response:**

```json
{
  "success": true,
  "transactionId": "FAC_1234567890_abc123",
  "message": "Payment processed successfully"
}
```

### FAC Payment Initiation

```http
POST /api/fac/payment
Authorization: Bearer <token>
Content-Type: application/json

{
  "amount": 5000,
  "currency": "JMD",
  "bookingId": "booking_123",
  "description": "Plumbing service booking"
}
```

**Response:**

```json
{
  "success": true,
  "transactionId": "FAC_1234567890_abc123",
  "is3DS": true,
  "redirectUrl": "https://3ds.fac.bm/auth?tid=FAC_1234567890_abc123",
  "message": "Payment initiated successfully"
}
```

### FAC 3DS Callback

```http
POST /api/fac/3ds-callback
Content-Type: application/json

{
  "transactionId": "FAC_1234567890_abc123",
  "pares": "eJzVWFmP2kgQ...",
  "md": "transaction_metadata"
}
```

### Get Transaction Status

```http
GET /api/fac/transaction/:transactionId
Authorization: Bearer <token>
```

**Response:**

```json
{
  "success": true,
  "transactionId": "FAC_1234567890_abc123",
  "status": "Transaction completed",
  "approvalCode": "APPROVED",
  "cardBrand": "VISA",
  "maskedCardNumber": "**** **** **** 1234",
  "amount": 5000,
  "currency": "JMD"
}
```

### Process Refund

```http
POST /api/fac/refund
Authorization: Bearer <token>
Content-Type: application/json

{
  "transactionId": "FAC_1234567890_abc123",
  "amount": 5000,
  "reason": "Customer cancellation"
}
```

## ⭐ Reviews

### Create Review

```http
POST /api/reviews
Authorization: Bearer <token>
Content-Type: application/json

{
  "professionalId": "pro_123",
  "bookingId": "booking_123",
  "rating": 5,
  "comment": "Excellent work, very professional and punctual"
}
```

**Response:**

```json
{
  "id": "rev_123",
  "clientId": "user_456",
  "professionalId": "pro_123",
  "bookingId": "booking_123",
  "rating": 5,
  "comment": "Excellent work, very professional and punctual",
  "createdAt": "2024-01-15T10:30:00Z"
}
```

### Get Professional Reviews

```http
GET /api/professionals/:id/reviews
```

**Response:**

```json
[
  {
    "id": "rev_123",
    "rating": 5,
    "comment": "Excellent work, very professional and punctual",
    "createdAt": "2024-01-15T10:30:00Z",
    "user": {
      "firstName": "Sarah",
      "lastName": "Wilson"
    }
  }
]
```

## 💬 Messages

### Send Message

```http
POST /api/messages
Authorization: Bearer <token>
Content-Type: application/json

{
  "recipientId": "user_456",
  "content": "Hi, I'm interested in your plumbing services"
}
```

**Response:**

```json
{
  "id": "msg_123",
  "senderId": "user_789",
  "recipientId": "user_456",
  "content": "Hi, I'm interested in your plumbing services",
  "isRead": false,
  "createdAt": "2024-01-15T10:30:00Z"
}
```

### Get Conversation

```http
GET /api/messages/conversation/:userId
Authorization: Bearer <token>
```

**Response:**

```json
[
  {
    "id": "msg_123",
    "senderId": "user_789",
    "recipientId": "user_456",
    "content": "Hi, I'm interested in your plumbing services",
    "isRead": false,
    "createdAt": "2024-01-15T10:30:00Z"
  },
  {
    "id": "msg_124",
    "senderId": "user_456",
    "recipientId": "user_789",
    "content": "Great! I'd be happy to help. What do you need?",
    "isRead": true,
    "createdAt": "2024-01-15T10:35:00Z"
  }
]
```

## 🔧 Admin

### Get All Users

```http
GET /api/admin/users
Authorization: Bearer <token>
```

**Response:**

```json
[
  {
    "id": "user_123",
    "email": "user@example.com",
    "firstName": "John",
    "lastName": "Doe",
    "isProfessional": false,
    "isVerified": true,
    "createdAt": "2024-01-15T10:30:00Z"
  }
]
```

### Verify Professional

```http
PUT /api/admin/users/:id/verify
Authorization: Bearer <token>
Content-Type: application/json

{
  "isVerified": true,
  "verificationNotes": "Documents verified successfully"
}
```

### Get Analytics Data

```http
GET /api/admin/analytics
Authorization: Bearer <token>
```

**Response:**

```json
{
  "totalUsers": 1250,
  "activeUsers": 890,
  "totalBookings": 567,
  "completedBookings": 489,
  "totalRevenue": 1250000,
  "averageBookingValue": 2200,
  "conversionRate": 0.78
}
```

## 📊 Analytics

### Get Metrics

```http
GET /api/analytics/metrics?startDate=2024-01-01&endDate=2024-01-31
Authorization: Bearer <token>
```

**Query Parameters:**

- `startDate` (optional): Start date for metrics
- `endDate` (optional): End date for metrics

**Response:**

```json
{
  "totalUsers": 1250,
  "activeUsers": 890,
  "totalBookings": 567,
  "completedBookings": 489,
  "totalRevenue": 1250000,
  "averageBookingValue": 2200,
  "conversionRate": 0.78,
  "topCategories": [
    {
      "category": "Plumbing",
      "count": 156
    }
  ],
  "userGrowth": [
    {
      "date": "2024-01-01",
      "users": 1200
    }
  ]
}
```

### Get Event Analytics

```http
GET /api/analytics/events/:eventType?startDate=2024-01-01&endDate=2024-01-31
Authorization: Bearer <token>
```

**Path Parameters:**

- `eventType`: Type of event (page_view, booking, payment, etc.)

**Response:**

```json
[
  {
    "id": "event_123",
    "userId": "user_456",
    "eventType": "page_view",
    "eventName": "Page Viewed",
    "properties": {
      "page": "/professionals",
      "referrer": "https://google.com"
    },
    "timestamp": "2024-01-15T10:30:00Z"
  }
]
```

### Get Conversion Funnel

```http
GET /api/analytics/funnel
Authorization: Bearer <token>
```

**Response:**

```json
{
  "stages": [
    {
      "stage": "Page View",
      "count": 1000,
      "conversionRate": 1.0
    },
    {
      "stage": "Professional View",
      "count": 450,
      "conversionRate": 0.45
    },
    {
      "stage": "Booking Created",
      "count": 89,
      "conversionRate": 0.2
    },
    {
      "stage": "Payment Completed",
      "count": 67,
      "conversionRate": 0.75
    }
  ]
}
```

## 📁 File Uploads

### Upload File

```http
POST /api/upload
Authorization: Bearer <token>
Content-Type: multipart/form-data

file: [binary file data]
type: verification_document
```

**Response:**

```json
{
  "success": true,
  "fileUrl": "/uploads/verification_document_123.pdf",
  "fileName": "verification_document_123.pdf",
  "fileSize": 1024000,
  "mimeType": "application/pdf"
}
```

### Supported File Types

- **Images**: JPEG, PNG, GIF
- **Documents**: PDF
- **Maximum Size**: 10MB

## 🔌 WebSocket

### Connection

```javascript
const ws = new WebSocket("ws://localhost:5000/ws");

ws.onopen = () => {
  console.log("Connected to chat server");
};

ws.onmessage = (event) => {
  const message = JSON.parse(event.data);
  console.log("New message:", message);
};
```

### Message Format

```json
{
  "type": "message",
  "senderId": "user_123",
  "recipientId": "user_456",
  "content": "Hello! How can I help you?",
  "timestamp": "2024-01-15T10:30:00Z"
}
```

### Message Types

- `message` - Chat message
- `typing` - Typing indicator
- `read` - Message read receipt
- `online` - User online status

## ❌ Error Handling

### Error Response Format

```json
{
  "success": false,
  "error": "Error message",
  "errorCode": "ERROR_CODE",
  "details": {
    "field": "Additional error details"
  }
}
```

### Common Error Codes

- `AUTH_REQUIRED` - Authentication required
- `INVALID_INPUT` - Invalid input data
- `NOT_FOUND` - Resource not found
- `PERMISSION_DENIED` - Insufficient permissions
- `PAYMENT_FAILED` - Payment processing failed
- `VALIDATION_ERROR` - Data validation failed

### HTTP Status Codes

- `200` - Success
- `201` - Created
- `400` - Bad Request
- `401` - Unauthorized
- `403` - Forbidden
- `404` - Not Found
- `422` - Validation Error
- `500` - Internal Server Error

### Example Error Responses

#### Authentication Required

```http
HTTP/1.1 401 Unauthorized
Content-Type: application/json

{
  "success": false,
  "error": "Authentication required",
  "errorCode": "AUTH_REQUIRED"
}
```

#### Validation Error

```http
HTTP/1.1 422 Unprocessable Entity
Content-Type: application/json

{
  "success": false,
  "error": "Validation failed",
  "errorCode": "VALIDATION_ERROR",
  "details": {
    "email": "Invalid email format",
    "phone": "Phone number is required"
  }
}
```

#### Resource Not Found

```http
HTTP/1.1 404 Not Found
Content-Type: application/json

{
  "success": false,
  "error": "Professional not found",
  "errorCode": "NOT_FOUND"
}
```

## 📝 Rate Limiting

### Limits

- **General API**: 100 requests per 15 minutes per IP
- **API Endpoints**: 50 requests per 15 minutes per IP
- **Authentication**: 10 login attempts per 15 minutes per IP

### Rate Limit Headers

```http
X-RateLimit-Limit: 100
X-RateLimit-Remaining: 95
X-RateLimit-Reset: 1642248600
```

### Rate Limit Exceeded Response

```http
HTTP/1.1 429 Too Many Requests
Content-Type: application/json

{
  "success": false,
  "error": "Too many requests from this IP, please try again after 15 minutes",
  "errorCode": "RATE_LIMIT_EXCEEDED",
  "retryAfter": 900
}
```

## 🔒 Security

### CORS Configuration

- **Allowed Origins**: Configured per environment
- **Methods**: GET, POST, PUT, DELETE, OPTIONS
- **Headers**: Content-Type, Authorization, X-Requested-With
- **Credentials**: Supported

### Security Headers

- **Helmet**: Security headers middleware
- **HSTS**: HTTPS enforcement
- **CSP**: Content Security Policy
- **XSS Protection**: XSS prevention headers

### Input Validation

- **Zod Schemas**: Type-safe validation
- **Sanitization**: HTML and script tag removal
- **Type Checking**: Runtime type validation

---

For additional support or questions about the API, please refer to the main README or create an issue in the repository.
