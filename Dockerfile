# Multi-stage build for SkillHands
FROM node:18-alpine AS base

# Install dependencies only when needed
FROM base AS deps
WORKDIR /app

# Copy package files
COPY package*.json ./
RUN npm ci --only=production

# Build the application
FROM base AS builder
WORKDIR /app

# Copy package files
COPY package*.json ./
RUN npm ci

# Copy source code
COPY . .

# Build the application
RUN npm run build

# Production image
FROM base AS runner
WORKDIR /app

# Create non-root user
RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 skillhands

# Copy built application
COPY --from=builder --chown=skillhands:nodejs /app/dist ./dist
COPY --from=deps --chown=skillhands:nodejs /app/node_modules ./node_modules
COPY --from=builder --chown=skillhands:nodejs /app/package*.json ./

# Create uploads directory
RUN mkdir -p uploads && chown skillhands:nodejs uploads

# Set environment variables
ENV NODE_ENV=production
ENV PORT=5000

# Expose port
EXPOSE 5000

# Switch to non-root user
USER skillhands

# Start the application
CMD ["node", "dist/index.js"]
