-- ═══════════════════════════════════════════════════════
-- Alhuda App Store — Supabase Setup
-- Run this in your Supabase SQL Editor
-- ═══════════════════════════════════════════════════════

-- 1. Apps table
CREATE TABLE IF NOT EXISTS store_apps (
  id            UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name          TEXT NOT NULL,
  name_ar       TEXT,
  developer     TEXT DEFAULT 'Alhuda Advance Hypermarket',
  description   TEXT,
  whats_new     TEXT,
  version       TEXT DEFAULT '1.0.0',
  size_mb       TEXT DEFAULT '~12 MB',
  platform      TEXT DEFAULT 'Android 8.0+',
  category      TEXT DEFAULT 'Business',
  icon_url      TEXT,
  apk_url       TEXT,
  status        TEXT DEFAULT 'draft',   -- 'published' | 'coming_soon' | 'draft'
  sort_order    INT  DEFAULT 0,
  rating        NUMERIC DEFAULT 5.0,
  created_at    TIMESTAMPTZ DEFAULT NOW(),
  updated_at    TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Screenshots table
CREATE TABLE IF NOT EXISTS store_screenshots (
  id          UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  app_id      UUID REFERENCES store_apps(id) ON DELETE CASCADE,
  url         TEXT NOT NULL,
  caption     TEXT,
  sort_order  INT DEFAULT 0
);

-- 3. Disable RLS (same as rest of your app)
ALTER TABLE store_apps        DISABLE ROW LEVEL SECURITY;
ALTER TABLE store_screenshots DISABLE ROW LEVEL SECURITY;

-- 4. Storage buckets — run these too
-- Go to Storage in Supabase dashboard and create:
--   • store-assets   (public bucket)
-- That's it — one bucket for icons, screenshots, and APKs

-- 5. Make the bucket public
-- In Supabase: Storage → store-assets → Policies → Enable public access
