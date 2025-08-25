#!/bin/bash

# Deploy environment variables to Vercel
# Run this script to set up all environment variables

echo "Setting up environment variables on Vercel..."

# Supabase
echo "Adding Supabase environment variables..."
vercel env add NEXT_PUBLIC_SUPABASE_URL production <<< "https://xyz.supabase.co"
vercel env add NEXT_PUBLIC_SUPABASE_ANON_KEY production <<< ""
vercel env add SUPABASE_SERVICE_ROLE_KEY production <<< ""

# AI Services
echo "Adding AI API keys..."
vercel env add GROQ_API_KEY production <<< "Y"
vercel env add MISTRAL_API_KEY production <<< ""
vercel env add TAVILY_API_KEY production <<< ""

# Google OAuth
echo "Adding Google OAuth credentials..."
vercel env add GOOGLE_CLIENT_ID production <<< ""
vercel env add GOOGLE_CLIENT_SECRET production <<< ""

# NextAuth
echo "Adding NextAuth configuration..."
vercel env add NEXTAUTH_URL production <<< ""
vercel env add NEXTAUTH_SECRET production <<< ""

# Email Service
echo "Adding email configuration..."
vercel env add EMAIL_NAME production <<< ""
vercel env add EMAIL_PASS production <<< ""

# WhatsApp (for future use)
echo "Adding WhatsApp placeholders..."
vercel env add WHATSAPP_ACCESS_TOKEN production <<< "dummy-token"
vercel env add WHATSAPP_PHONE_NUMBER_ID production <<< "dummy-phone-id"
vercel env add WHATSAPP_WEBHOOK_VERIFY_TOKEN production <<< "dummy-verify-token"

echo "✅ All environment variables added to Vercel!"
echo "🚀 Your app should now work at: "