# Finvoice AI

A comprehensive voice-first financial management application with WhatsApp integration, built with Next.js 15, TypeScript, and shadcn/ui.

## 🚀 Features

- **Voice Input**: Record expenses using voice commands
- **AI Processing**: Groq AI for speech-to-text and expense extraction
- **WhatsApp Integration**: Manage expenses via WhatsApp messages
- **Dashboard Analytics**: Interactive charts and expense tracking
- **PDF Reports**: Generate detailed expense reports
- **Modern UI**: Built with shadcn/ui components and custom theming

## 🛠️ Tech Stack

- **Framework**: Next.js 15 with App Router
- **Language**: TypeScript
- **Styling**: Tailwind CSS v4 with custom oklch theme
- **UI Components**: shadcn/ui
- **Database**: Supabase
- **AI Services**: Groq (Whisper + LLaMA)
- **Authentication**: NextAuth.js (Google OAuth)
- **Charts**: Chart.js + react-chartjs-2
- **PDF Generation**: jsPDF + html2canvas
- **Audio Processing**: Web Audio API + WaveSurfer.js

## 📁 Project Structure

```
finvoice-ai/
├── app/
│   ├── (dashboard)/
│   │   ├── dashboard/
│   │   │   └── page.tsx          # Main dashboard page
│   │   └── layout.tsx            # Dashboard layout with sidebar
│   ├── api/
│   │   ├── voice/
│   │   │   └── route.ts          # Voice processing API
│   │   └── whatsapp/
│   │       └── webhook/
│   │           └── route.ts      # WhatsApp webhook handler
│   ├── globals.css               # Global styles with custom theme
│   ├── layout.tsx                # Root layout
│   └── page.tsx                  # Home page (redirects to dashboard)
├── components/
│   ├── dashboard/
│   │   ├── expense-chart.tsx     # Chart components
│   │   ├── expense-stats.tsx     # Statistics cards
│   │   ├── recent-expenses.tsx   # Recent expenses list
│   │   └── voice-input.tsx       # Voice recording component
│   ├── layout/
│   │   ├── header.tsx            # Dashboard header
│   │   └── sidebar.tsx           # Navigation sidebar
│   ├── providers/
│   │   └── session-provider.tsx  # NextAuth session provider
│   └── ui/                       # shadcn/ui components
├── lib/
│   ├── api/
│   │   ├── groq.ts              # Groq AI client
│   │   └── supabase.ts          # Supabase client
│   └── utils/
│       └── pdf-generator.ts      # PDF report generator
├── hooks/
│   └── use-mobile.ts            # Mobile detection hook
├── .env.local                   # Environment variables
└── package.json
```

## 🔧 Installation & Setup

### 1. Clone and Install Dependencies

```bash
# Clone the repository
git clone <repository-url>
cd finvoice-ai

# Install dependencies
npm install
```

### 2. Environment Variables

Update `.env.local` with your actual API keys:

```env
# Supabase
NEXT_PUBLIC_SUPABASE_URL=your_supabase_project_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key

# Groq API
GROQ_API_KEY=your_groq_api_key

# Google OAuth
GOOGLE_CLIENT_ID=your_google_client_id
GOOGLE_CLIENT_SECRET=your_google_client_secret

# NextAuth
NEXTAUTH_URL=http://localhost:3000
NEXTAUTH_SECRET=your_nextauth_secret

# WhatsApp Business API
WHATSAPP_ACCESS_TOKEN=your_whatsapp_access_token
WHATSAPP_PHONE_NUMBER_ID=your_whatsapp_phone_id
WHATSAPP_WEBHOOK_VERIFY_TOKEN=your_webhook_verify_token

# Tavily AI (Optional)
TAVILY_API_KEY=your_tavily_api_key
```

### 3. Database Setup (Supabase)

Create the following tables in your Supabase database:

```sql
-- Users table
CREATE TABLE users (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  email TEXT UNIQUE NOT NULL,
  name TEXT,
  avatar_url TEXT,
  phone TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Expenses table
CREATE TABLE expenses (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  amount DECIMAL(10,2) NOT NULL,
  category TEXT NOT NULL,
  vendor TEXT,
  date DATE NOT NULL,
  description TEXT,
  source TEXT DEFAULT 'web',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Enable Row Level Security
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE expenses ENABLE ROW LEVEL SECURITY;

-- Create policies (adjust as needed)
CREATE POLICY "Users can view own data" ON users
  FOR SELECT USING (auth.uid() = id);

CREATE POLICY "Users can insert own data" ON users
  FOR INSERT WITH CHECK (auth.uid() = id);

CREATE POLICY "Users can view own expenses" ON expenses
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own expenses" ON expenses
  FOR INSERT WITH CHECK (auth.uid() = user_id);
```

### 4. External API Setup

#### Groq API
1. Sign up at [console.groq.com](https://console.groq.com)
2. Create an API key
3. Add to `.env.local`

#### Google OAuth
1. Go to [Google Cloud Console](https://console.cloud.google.com)
2. Create OAuth 2.0 credentials
3. Add redirect URI: `http://localhost:3000/api/auth/callback/google`
4. Add client ID and secret to `.env.local`

#### WhatsApp Business API
1. Apply at [WhatsApp Business Platform](https://business.whatsapp.com/)
2. Get access token and phone number ID
3. Configure webhook URL: `https://your-domain.com/api/whatsapp/webhook`
4. Add credentials to `.env.local`

### 5. Run the Application

```bash
# Development mode
npm run dev

# Build for production
npm run build

# Start production server
npm start
```

## 📱 Usage

### Voice Input
1. Click the microphone button on the dashboard
2. Say your expense (e.g., "I spent 500 rupees on lunch today")
3. The AI will extract amount, category, and vendor information
4. Review and confirm the expense

### WhatsApp Integration
1. Send a text message to your WhatsApp Business number
2. Example: "Paid 2000 for electricity bill"
3. The system will process and save the expense
4. You'll receive a confirmation message

### Dashboard Features
- **Expense Statistics**: Total, monthly, weekly, and daily averages
- **Interactive Charts**: Line charts for trends, doughnut charts for categories
- **Recent Expenses**: Latest transactions with categories
- **PDF Reports**: Download detailed expense reports

## 🎨 Theming

The application uses a custom oklch color theme optimized for accessibility and modern design. The theme supports both light and dark modes.

Key design features:
- Custom CSS variables for consistent theming
- shadcn/ui components with theme integration
- Responsive design for all screen sizes
- Smooth animations and transitions

## 🚀 Deployment

### Vercel Deployment
```bash
# Install Vercel CLI
npm i -g vercel

# Login and deploy
vercel login
vercel --prod
```

Add all environment variables in the Vercel dashboard under Settings > Environment Variables.

### Environment Configuration
- Set webhook URLs for production
- Update NEXTAUTH_URL for your domain
- Configure CORS settings for APIs

## 🧪 Testing

### Voice Input Testing
1. Test with various expense formats
2. Verify microphone permissions
3. Check transcription accuracy

### WhatsApp Testing
1. Send test messages to your business number
2. Verify webhook responses
3. Test expense parsing accuracy

### PDF Generation Testing
1. Generate reports with different data sets
2. Test chart rendering in PDFs
3. Verify download functionality

## 🔒 Security Notes

- All API keys are server-side only (except Supabase public key)
- Row Level Security enabled on database
- Input validation on all endpoints
- CORS configuration for API routes
- Environment variables validation

## 📈 Performance Optimizations

- Static generation where possible
- Code splitting with dynamic imports
- Image optimization with Next.js
- Efficient chart rendering
- Lazy loading of components

## 🐛 Troubleshooting

### Common Issues

1. **Build Errors**: Check TypeScript errors and dependency versions
2. **API Failures**: Verify environment variables and API keys
3. **Voice Not Working**: Check browser permissions and HTTPS requirement
4. **WhatsApp Issues**: Verify webhook URL and token configuration

### Development Tips

- Use browser dev tools for debugging voice input
- Check Network tab for API call issues
- Monitor console for JavaScript errors
- Use Supabase dashboard for database debugging

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Follow the existing code style
4. Add tests for new features
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- shadcn/ui for the excellent component library
- Groq for powerful AI services
- Supabase for backend infrastructure
- Vercel for deployment platform