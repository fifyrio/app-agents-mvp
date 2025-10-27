import { Hono } from 'hono';
import { cors } from 'hono/cors';

const app = new Hono();

// Enable CORS for Flutter frontend
app.use('/*', cors());

// Health check endpoint
app.get('/', (c) => {
  return c.json({
    message: 'Welcome to my-app backend API',
    status: 'healthy',
    timestamp: new Date().toISOString()
  });
});

// API routes
app.get('/api/health', (c) => {
  return c.json({ status: 'ok' });
});

// Example API endpoint
app.get('/api/hello', (c) => {
  const name = c.req.query('name') || 'World';
  return c.json({ message: `Hello, ${name}!` });
});

// Wardrobe endpoint - Returns outfit recommendations and filters
app.get('/wardrobe', (c) => {
  return c.json({
    filters: [
      { id: "all", title: "All", selected: true },
      { id: "work", title: "Work", selected: false },
      { id: "date", title: "Date", selected: false },
      { id: "travel", title: "Travel", selected: false },
      { id: "party", title: "Party", selected: false },
      { id: "interview", title: "Interview", selected: false }
    ],
    scenes: [
      {
        id: "chic_city_brunch",
        title: "Chic City Brunch",
        subtitle: "Cool summer palette",
        palette: ["#2B3A42", "#E4E8EB", "#F9C9C8"],
        image_url: "https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?w=400",
        tags: ["premium"],
        category: "date",
        is_premium: true
      },
      {
        id: "boardroom_ready",
        title: "Boardroom Ready",
        subtitle: "Deep winter power look",
        palette: ["#1C1C1E", "#E04E39", "#A9B0B7"],
        image_url: "https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=400",
        tags: [],
        category: "work",
        is_premium: false
      },
      {
        id: "sunset_dinner_date",
        title: "Sunset Dinner Date",
        subtitle: "Warm autumn romance",
        palette: ["#D35400", "#C0392B", "#F39C12", "#E67E22"],
        image_url: "https://images.unsplash.com/photo-1529139574466-a303027c1d8b?w=400",
        tags: [],
        category: "date",
        is_premium: false
      },
      {
        id: "casual_weekend_wander",
        title: "Casual Weekend Wander",
        subtitle: "Soft spring comfort",
        palette: ["#27AE60", "#3498DB", "#FFC0CB"],
        image_url: "https://images.unsplash.com/photo-1487222477894-8943e31ef7b2?w=400",
        tags: [],
        category: "travel",
        is_premium: false
      },
      {
        id: "garden_party_elegance",
        title: "Garden Party Elegance",
        subtitle: "Bright spring florals",
        palette: ["#E91E63", "#9C27B0", "#FFC107"],
        image_url: "https://images.unsplash.com/photo-1469334031218-e382a71b716b?w=400",
        tags: ["premium"],
        category: "party",
        is_premium: true
      },
      {
        id: "professional_presence",
        title: "Professional Presence",
        subtitle: "Classic interview ready",
        palette: ["#34495E", "#ECF0F1", "#2C3E50"],
        image_url: "https://images.unsplash.com/photo-1551232864-3f0890e580d9?w=400",
        tags: [],
        category: "interview",
        is_premium: false
      },
      {
        id: "travel_in_style",
        title: "Travel in Style",
        subtitle: "Comfortable chic",
        palette: ["#8B4513", "#D2691E", "#DEB887"],
        image_url: "https://images.unsplash.com/photo-1483985988355-763728e1935b?w=400",
        tags: ["premium"],
        category: "travel",
        is_premium: true
      },
      {
        id: "office_power_move",
        title: "Office Power Move",
        subtitle: "Bold confidence",
        palette: ["#B22222", "#000000", "#FFFFFF"],
        image_url: "https://images.unsplash.com/photo-1592328715880-e335f08cb905?w=400",
        tags: [],
        category: "work",
        is_premium: false
      }
    ]
  });
});

export default app;
