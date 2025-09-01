# First Atlantic Commerce (FAC) Integration Guide

## Overview

First Atlantic Commerce (FAC) is a robust, PCI-compliant payment gateway widely used across Jamaica and the broader Caribbean. This guide covers the complete integration of FAC with the SkillHands marketplace application.

## 🏗️ Architecture

### FAC Service Structure
```
server/facPayment.ts          # Core FAC payment service
server/payment.ts            # Main payment service (integrates FAC)
server/routes.ts             # API endpoints for FAC operations
```

### Key Components
- **FACPaymentService**: Handles all FAC payment operations
- **PowerTranz API Integration**: Supports 3DS Simplified, Hybrid, and Non-3DS APIs
- **3DS Authentication Flow**: Complete 3D Secure implementation
- **Transaction Management**: Authorize, capture, refund, and status checking

## 🔧 Configuration

### Environment Variables
```env
# First Atlantic Commerce (FAC) - Jamaican Payment Gateway
FAC_MERCHANT_ID=your_fac_merchant_id_here
FAC_POWERTRANZ_ID=your_powertranz_id_here
FAC_POWERTRANZ_PASSWORD=your_powertranz_password_here
FAC_ENVIRONMENT=test
FAC_API_VERSION=2.8
```

### API Versions Supported
- **2.8**: PowerTranz Simplified 3DS API (recommended for standard e-commerce)
- **2.2**: PowerTranz Hybrid 3DS API (advanced features)
- **2.0**: PowerTranz Non-3DS API (jurisdictions without 3DS requirement)

## 🚀 Getting Started

### 1. Apply for FAC Merchant Account
1. Visit [firstatlanticcommerce.com](https://firstatlanticcommerce.com)
2. Complete the online application form
3. Partner with local banks for account setup
4. Receive access to Merchant Portal

### 2. Configure Merchant Portal
1. **Create User Roles**:
   - Developer role for API access
   - Admin role for configuration management
   - Support role for customer service

2. **API Configuration**:
   - Generate PowerTranz ID and password
   - Configure allowed IP addresses
   - Set up webhook endpoints

### 3. Update Environment Configuration
```bash
# Copy environment template
cp .env.example .env

# Edit with your FAC credentials
nano .env
```

## 📱 API Endpoints

### Payment Initiation
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

**Response**:
```json
{
  "success": true,
  "transactionId": "FAC_1234567890_abc123",
  "is3DS": true,
  "redirectUrl": "https://3ds.fac.bm/auth?tid=FAC_1234567890_abc123",
  "message": "Payment initiated successfully"
}
```

### 3DS Callback Processing
```http
POST /api/fac/3ds-callback
Content-Type: application/json

{
  "transactionId": "FAC_1234567890_abc123",
  "pares": "eJzVWFmP2kgQ...",
  "md": "transaction_metadata"
}
```

### Transaction Status Check
```http
GET /api/fac/transaction/{transactionId}
Authorization: Bearer <token>
```

### Refund Processing
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

### Configuration Status
```http
GET /api/fac/config
Authorization: Bearer <token>
```

## 🔄 Payment Flow

### Standard Payment Flow
```
1. Client initiates payment
   ↓
2. FAC payment request created
   ↓
3. Payment processed (with/without 3DS)
   ↓
4. Transaction completed
   ↓
5. Booking confirmed
```

### 3DS Authentication Flow
```
1. Payment initiated
   ↓
2. 3DS authentication required
   ↓
3. Client redirected to 3DS page
   ↓
4. Authentication completed
   ↓
5. Callback processed
   ↓
6. Transaction completed
```

## 💳 Supported Features

### Transaction Types
- **Authorize**: Pre-authorize payment
- **Capture**: Complete authorized payment
- **Refund**: Process refunds
- **Reverse**: Cancel pending transactions
- **PreAuthorize**: Hold funds temporarily

### Currencies
- **JMD**: Jamaican Dollar (primary)
- **USD**: US Dollar
- **EUR**: Euro
- **GBP**: British Pound

### Processing Fees
- **JMD**: 2.8%
- **USD**: 2.9%
- **EUR**: 2.9%
- **GBP**: 2.9%

## 🛡️ Security Features

### PCI Compliance
- FAC maintains PCI DSS Level 1 compliance
- Secure tokenization for card data
- Encrypted API communications

### 3D Secure
- Supports 3DS 2.0 and 2.1
- Risk-based authentication
- Enhanced security for international cards

### Fraud Prevention
- Real-time fraud detection
- Address verification (AVS)
- Card verification value (CVV) validation

## 🔍 Testing

### Test Environment
```env
FAC_ENVIRONMENT=test
FAC_API_VERSION=2.8
```

### Test Cards
- **Visa**: 4111111111111111
- **Mastercard**: 5555555555554444
- **3DS Test**: 4000000000000002

### Test Scenarios
1. **Successful Payment**: Standard payment flow
2. **3DS Authentication**: Payment requiring 3DS
3. **Declined Payment**: Insufficient funds
4. **Refund Processing**: Partial and full refunds
5. **Error Handling**: Network failures, invalid data

## 📊 Analytics & Tracking

### Events Tracked
- **Payment Initiated**: When payment is started
- **3DS Completed**: After 3DS authentication
- **Refund Processed**: When refund is completed

### Metrics Available
- Transaction success rates
- 3DS authentication rates
- Processing times
- Error rates by type

## 🚀 Production Deployment

### 1. Environment Setup
```env
FAC_ENVIRONMENT=production
FAC_API_VERSION=2.8
```

### 2. SSL Certificate
- Ensure HTTPS is enabled
- Valid SSL certificate required
- 3DS callbacks must use HTTPS

### 3. Webhook Configuration
- Configure callback URLs in FAC portal
- Set up retry mechanisms
- Monitor webhook delivery

### 4. Monitoring
- Transaction logs
- Error rate monitoring
- Performance metrics
- Security alerts

## 🔧 Troubleshooting

### Common Issues

#### 1. Authentication Errors
```json
{
  "success": false,
  "errorCode": "AUTH_ERROR",
  "errorMessage": "Invalid PowerTranz credentials"
}
```

**Solution**: Verify FAC_MERCHANT_ID, FAC_POWERTRANZ_ID, and FAC_POWERTRANZ_PASSWORD

#### 2. 3DS Callback Failures
```json
{
  "success": false,
  "errorCode": "3DS_CALLBACK_ERROR",
  "errorMessage": "Invalid 3DS callback data"
}
```

**Solution**: Ensure callback endpoint is accessible and properly configured

#### 3. Transaction Not Found
```json
{
  "success": false,
  "errorCode": "STATUS_ERROR",
  "errorMessage": "Transaction not found"
}
```

**Solution**: Verify transaction ID format and check FAC portal

### Debug Mode
```env
NODE_ENV=development
DEBUG=fac:*
```

## 📚 Additional Resources

### FAC Documentation
- [PowerTranz API Documentation](https://support.fac.bm)
- [Merchant Portal Guide](https://firstatlanticcommerce.com)
- [Integration Examples](https://github.com/fac-examples)

### Support Channels
- **Technical Support**: support@fac.bm
- **Merchant Services**: merchants@fac.bm
- **Emergency**: +1 (441) 295-3322

### Community Resources
- [FAC Developer Forum](https://community.fac.bm)
- [Integration Best Practices](https://docs.fac.bm)
- [Testing Guidelines](https://test.fac.bm)

## 🎯 Best Practices

### 1. Error Handling
- Implement comprehensive error handling
- Log all transaction attempts
- Provide user-friendly error messages

### 2. Security
- Never log sensitive card data
- Use HTTPS for all communications
- Implement rate limiting

### 3. User Experience
- Clear payment flow instructions
- Progress indicators for 3DS
- Confirmation messages

### 4. Monitoring
- Track success/failure rates
- Monitor processing times
- Alert on unusual patterns

## 🚀 Next Steps

### Immediate Actions
1. ✅ Set up FAC merchant account
2. ✅ Configure environment variables
3. ✅ Test payment flows
4. ✅ Implement error handling
5. ✅ Set up monitoring

### Future Enhancements
- Recurring billing support
- Advanced fraud detection
- Multi-currency optimization
- Mobile SDK integration

---

**Note**: This integration provides a production-ready FAC payment solution for SkillHands. Always test thoroughly in the test environment before going live.

For additional support, contact the FAC integration team or refer to the official FAC documentation.
