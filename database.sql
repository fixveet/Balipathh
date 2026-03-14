-- ============================================================
--  BALIPATH — Supabase Schema + Seed Data
-- ============================================================

-- ── 1. PACKAGES ─────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS packages (
  id          BIGSERIAL PRIMARY KEY,
  name        TEXT        NOT NULL,
  location    TEXT        NOT NULL,
  duration    TEXT,
  price       NUMERIC     NOT NULL DEFAULT 0,
  status      TEXT        NOT NULL DEFAULT 'active' CHECK (status IN ('active','draft','paused')),
  img         TEXT,
  "desc"      TEXT,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ── 2. RENTALS ──────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS rentals (
  id          BIGSERIAL PRIMARY KEY,
  name        TEXT        NOT NULL,
  location    TEXT        NOT NULL,
  type        TEXT,
  price       NUMERIC     NOT NULL DEFAULT 0,
  badge       TEXT,
  status      TEXT        NOT NULL DEFAULT 'active' CHECK (status IN ('active','draft','paused')),
  img         TEXT,
  "desc"      TEXT,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ── 3. SOUVENIRS ────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS souvenirs (
  id          BIGSERIAL PRIMARY KEY,
  name        TEXT        NOT NULL,
  category    TEXT        NOT NULL CHECK (category IN ('Kerajinan','Makanan','Tekstil','Spa')),
  stock       INTEGER     NOT NULL DEFAULT 0,
  price       NUMERIC     NOT NULL DEFAULT 0,
  origin      TEXT,
  status      TEXT        NOT NULL DEFAULT 'active' CHECK (status IN ('active','draft','sold')),
  img         TEXT,
  "desc"      TEXT,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ── 4. ROW LEVEL SECURITY ────────────────────────────────────
ALTER TABLE packages  ENABLE ROW LEVEL SECURITY;
ALTER TABLE rentals   ENABLE ROW LEVEL SECURITY;
ALTER TABLE souvenirs ENABLE ROW LEVEL SECURITY;

CREATE POLICY "allow_all_packages"  ON packages  FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "allow_all_rentals"   ON rentals   FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "allow_all_souvenirs" ON souvenirs FOR ALL USING (true) WITH CHECK (true);

-- ── 5. SEED DATA — PACKAGES ──────────────────────────────────
INSERT INTO packages (name, location, duration, price, status, img, "desc") VALUES
  ('Ubud Zen Escape',        'Ubud, Bali',       '5 Days, 4 Nights', 1250, 'active',
   'https://images.unsplash.com/photo-1555400038-63f5ba517a47?w=120&q=70',
   'Serene Ubud retreat surrounded by rice terraces and jungle.'),
  ('Uluwatu Surf & Sun',     'Uluwatu, Bali',    '7 Days, 6 Nights', 1890, 'active',
   'https://images.unsplash.com/photo-1573790387438-4da905039392?w=120&q=70',
   'Catch waves at the world-famous Uluwatu break.'),
  ('Seminyak Luxe Life',     'Seminyak, Bali',   '4 Days, 3 Nights',  950, 'draft',
   'https://images.unsplash.com/photo-1537996194471-e657df975ab4?w=120&q=70',
   'Trendy Seminyak with beach clubs and fine dining.'),
  ('Nusa Penida Expedition',  'Nusa Penida, Bali','3 Days, 2 Nights',  780, 'paused',
   'https://images.unsplash.com/photo-1518548419970-58e3b4079ab2?w=120&q=70',
   'Kelingking Beach, Angel Billabong and Broken Beach.'),
  ('Canggu Surf Weekend',    'Canggu, Bali',     '3 Days, 2 Nights',  620, 'active',
   'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=120&q=70',
   'Laid-back Canggu with surf lessons and café culture.'),
  ('Lovina Dolphin Sunrise', 'Lovina, Bali',     '2 Days, 1 Night',   380, 'active',
   'https://images.unsplash.com/photo-1506953823976-52e1fdc0149a?w=120&q=70',
   'Early morning dolphin watching on the tranquil north coast.');

-- ── 6. SEED DATA — RENTALS ───────────────────────────────────
INSERT INTO rentals (name, location, type, price, badge, status, img, "desc") VALUES
  ('Honda Beat / Vario',          'Canggu',    'motor',  75,  'recommended', 'active',
   'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=120&q=70',
   'Motor matic populer, cocok untuk keliling Canggu.'),
  ('Yamaha NMAX 155',             'Ubud',      'motor', 110, 'popular',     'active',
   'https://images.unsplash.com/photo-1449426468159-d96dbf08f19f?w=120&q=70',
   'Matic premium nyaman untuk medan berbukit Ubud.'),
  ('Toyota Avanza (Manual)',      'Denpasar',  'mobil', 350, '',            'active',
   'https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?w=120&q=70',
   'MPV keluarga 7-seater, bisa dengan atau tanpa sopir.'),
  ('Toyota Fortuner 4x4',         'Seminyak',  'mobil', 750, '',            'active',
   'https://images.unsplash.com/photo-1546614042-7df3c24c9e5d?w=120&q=70',
   'SUV premium untuk safari atau perjalanan ke gunung.'),
  ('Speedboat Bali–Nusa Penida',  'Sanur',     'boat',  200, '',            'active',
   'https://images.unsplash.com/photo-1567899378494-47b22a2ae96a?w=120&q=70',
   'Penyeberangan cepat Sanur–Nusa Penida 30 menit.'),
  ('Private Boat Charter',        'Lovina',    'boat',  900, '',            'active',
   'https://images.unsplash.com/photo-1504507926084-34cf0b939964?w=120&q=70',
   'Sewa boat private untuk dolphin watching & island hopping.');

-- ── 7. SEED DATA — SOUVENIRS ─────────────────────────────────
INSERT INTO souvenirs (name, category, stock, price, origin, status, img, "desc") VALUES
  ('Carved Wooden Barong',        'Kerajinan',  35,  95, 'Mas Village, Ubud',  'active',
   'https://images.unsplash.com/photo-1565299585323-38d6b0865b47?w=120&q=70',
   'Hand-carved Barong mask, simbol perlindungan dalam mitologi Bali.'),
  ('Batik Painting – Tegalalang', 'Kerajinan',  18, 120, 'Ubud, Bali',         'active',
   'https://images.unsplash.com/photo-1555400038-63f5ba517a47?w=120&q=70',
   'Lukisan batik asli bertema sawah Tegalalang, dibuat oleh seniman Ubud.'),
  ('Silver Kecak Pendant',        'Kerajinan',  60,  38, 'Celuk, Bali',        'active',
   'https://images.unsplash.com/photo-1535632787350-4e68ef0ac584?w=120&q=70',
   'Kalung perak sterling motif tari Kecak dari pengrajin Desa Celuk.'),
  ('Kopi Kintamani Premium',      'Makanan',   200,  22, 'Kintamani, Bali',    'active',
   'https://images.unsplash.com/photo-1447933601403-0c6688de566e?w=120&q=70',
   'Single origin arabika dari lereng Gunung Batur, rasa citrus segar.'),
  ('Pie Susu Bali Assorted',      'Makanan',   150,  15, 'Denpasar, Bali',     'active',
   'https://images.unsplash.com/photo-1558961363-fa8fdf82db35?w=120&q=70',
   'Pie susu khas Bali isi 20 pcs, rasa original, pandan, coklat, stroberi.'),
  ('Sambal Matah Kemasan',        'Makanan',    80,  12, 'Seminyak, Bali',     'active',
   'https://images.unsplash.com/photo-1563245372-f21724e3856d?w=120&q=70',
   'Sambal matah autentik dalam kemasan vakum tahan 3 bulan.'),
  ('Handwoven Ikat Sarong',       'Tekstil',   120,  45, 'Gianyar, Bali',      'active',
   'https://images.unsplash.com/photo-1610701596007-11502861dcfa?w=120&q=70',
   'Kain ikat tradisional celup tangan oleh pengrajin lokal Gianyar.'),
  ('Kemeja Batik Bali Unisex',    'Tekstil',    55,  35, 'Klungkung, Bali',    'active',
   'https://images.unsplash.com/photo-1596755094514-f87e34085b2c?w=120&q=70',
   'Kemeja batik cap motif endek Bali, bahan katun adem.'),
  ('Tenun Gringsing Klungkung',   'Tekstil',     8, 180, 'Klungkung, Bali',    'active',
   'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=120&q=70',
   'Kain tenun gringsing langka dari Tenganan, proses tenun bertahun-tahun.'),
  ('Lemongrass Spa Gift Set',     'Spa',         45,  62, 'Seminyak, Bali',    'active',
   'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=120&q=70',
   'Set spa: body scrub serai, minyak urut, dan lilin aromaterapi Bali.'),
  ('Virgin Coconut Oil Bali',     'Spa',         90,  18, 'Tabanan, Bali',     'active',
   'https://images.unsplash.com/photo-1474979266404-7eaacbcd87c5?w=120&q=70',
   'VCO cold press murni 250ml, untuk kulit, rambut, dan masak.'),
  ('Boreh Body Scrub Tradisional','Spa',          30,  28, 'Ubud, Bali',        'active',
   'https://images.unsplash.com/photo-1600880292203-757bb62b4baf?w=120&q=70',
   'Boreh rempah tradisional Bali: jahe, kunyit, beras — resep dari Ubud.');