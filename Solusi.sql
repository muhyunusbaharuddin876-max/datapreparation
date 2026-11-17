---Bagian A — Eksplorasi
-- Membuat tabel
CREATE TABLE datamentah_kecamatan (
    id         serial PRIMARY KEY,
    kode       text,
    nama       text,
    kabupaten  text,
    provinsi   text,
    lat        text,
    lon        text,
    populasi   text,
    sumber     text,
    updated_at text
);
-- Memasukkan data ke tabel raw_kecamatan
INSERT INTO datamentah_kecamatan (
    kode,
    nama,
    kabupaten,
    provinsi,
    lat,
    lon,
    populasi,
    sumber,
    updated_at
)
VALUES
    (
        '3323010', 'Temanggung ', 'Temanggung', 'Jawa Tengah',
        '-7.3160', '110.1740', '50.123', 'bps', '2025-01-10'
    ),
    (
        '3323010', 'TEMANGGUNG', 'Temanggung', 'JAWA TENGAH',
        '-7.3160', '110.1740', '50123', 'bps', '2025-03-02'
    ),
    (
        '3323020', 'Kranggan', 'Kabupaten Temanggung', 'Jawa Tengah',
        '-7.2900', '110.1800', '38.540', 'bps', '2025-01-10'
    ),
    (
        '3323030', 'Pringsurat', 'Temanggung', 'Jawa Tengah',
        '110.0900', '-7.2500', '41200', 'bps', '2025-01-10'
    ),
    (
        '3323040', 'Kaloran', 'Temanggung', ' Jawa Tengah',
        '-7.2000', '110.0000', NULL, 'bps', '2025-01-10'
    ),
    (
        '3323050', 'Kandangan', 'Temanggung', 'Jawa Tengah',
        '', '', '45.100', 'bps', '2025-01-10'
    ),
    (
        '3374010', 'Semarang Tengah', 'Kota Semarang', 'Jawa Tengah',
        '-6.9800', '110.4200', '52.300', 'bps', '2025-02-01'
    ),
    (
        '3374020', 'Semarang Utara', 'Kota Semarang', 'jawa tengah',
        '-6.9500', '110.4100', '120.000', 'bps', '2025-02-01'
    ),
    (
        '3471010', 'Tegalrejo', 'Kota Yogyakarta', 'DI Yogyakarta',
        '-7.7800', '110.3600', '37.800', 'bps', '2025-02-01'
    ),
    (
        '3471020', 'Jetis', 'Kota Yogyakarta', 'DI Yogyakarta',
        '-77.8000', '110.3600', '27.100', 'bps', '2025-02-01'
    ),
    (
        '3471030', 'Gondokusuman', 'Kota Yogyakarta', 'DI Yogyakarta',
        '-7.7900', '110.3750', 'abc', 'bps', '2025-02-01'
    ),
    (
        '3471030', 'Gondokusuman', 'Kota Yogyakarta', 'DI Yogyakarta',
        '-7.7900', '110.3750', '44.000', 'bps', '2025-01-05'
    );
	
-- Menampilkan tabel yang sudah dibuat
SELECT * FROM public.datamentah_kecamatan
ORDER BY id ASC

-- Menghitung total baris dan jumlah kode yang unik
SELECT
    COUNT(*) AS total_baris,
    COUNT(DISTINCT kode) AS jumlah_kode_unik
FROM datamentah_kecamatan;

-- Menampilkan kode yang muncul lebih dari sekali
SELECT
    kode,
    COUNT(*) AS jumlah_kemunculan
FROM datamentah_kecamatan
GROUP BY kode
HAVING COUNT(*) > 1
ORDER BY kode

-- Melihat dan Menghitung berapa banyak data kosong dan null pada tabel 
SELECT
    COUNT(*) AS total_data,
    COUNT(kode) AS kode_terisi,
    COUNT(nama) AS nama_terisi,
    COUNT(kabupaten) AS kabupaten_terisi,
    COUNT(provinsi) AS provinsi_terisi,
    COUNT(lat) AS lat_terisi,
    COUNT(lon) AS lon_terisi,
    COUNT(populasi) AS populasi_terisi
FROM datamentah_kecamatan;
SELECT *
FROM datamentah_kecamatan
WHERE 'id' = ''
     or kode = ''
	 or nama = ''
	 or kabupaten = ''
	 or provinsi = ''
	 or lat = ''
     or lon = ''
     or populasi = '';
SELECT *
FROM datamentah_kecamatan
WHERE 'id' IS NULL
   OR kode IS NULL
   OR nama IS NULL
   OR kabupaten IS NULL
   OR provinsi IS NULL
   OR lat IS NULL
   OR lon IS NULL
   OR populasi IS NULL;
SELECT
    COUNT(CASE WHEN kode IS NULL THEN 1 END) AS kode_null,
    COUNT(CASE WHEN kode = '' THEN 1 END) AS kode_kosong,

    COUNT(CASE WHEN nama IS NULL THEN 1 END) AS nama_null,
    COUNT(CASE WHEN nama = '' THEN 1 END) AS nama_kosong,

    COUNT(CASE WHEN kabupaten IS NULL THEN 1 END) AS kabupaten_null,
    COUNT(CASE WHEN kabupaten = '' THEN 1 END) AS kabupaten_kosong,

    COUNT(CASE WHEN provinsi IS NULL THEN 1 END) AS provinsi_null,
    COUNT(CASE WHEN provinsi = '' THEN 1 END) AS provinsi_kosong,

    COUNT(CASE WHEN lat IS NULL THEN 1 END) AS lat_null,
    COUNT(CASE WHEN lat = '' THEN 1 END) AS lat_kosong,

    COUNT(CASE WHEN lon IS NULL THEN 1 END) AS lon_null,
    COUNT(CASE WHEN lon = '' THEN 1 END) AS lon_kosong,

    COUNT(CASE WHEN populasi IS NULL THEN 1 END) AS populasi_null,
    COUNT(CASE WHEN populasi = '' THEN 1 END) AS populasi_kosong

FROM datamentah_kecamatan;

-- Melihat variasi penulisan provinsi dan jumlahnya
SELECT
    provinsi,
    COUNT(*) AS jumlah
FROM datamentah_kecamatan
GROUP BY provinsi;

---Bagian B — Cleaning
-- Membuat tabel baru dari data mentah
CREATE TABLE cleans_kecamatan AS

WITH data_bersih AS (
    SELECT
        id,
        kode,

        -- Membersihkan nama dan kapitalisasi
        INITCAP(BTRIM(nama)) AS nama,

        -- Menghapus awalan Kabupaten
        REGEXP_REPLACE(
            BTRIM(kabupaten),
            '^Kabupaten[[:space:]]+',
            '',
            'i'
        ) AS kabupaten,

        -- Menyeragamkan penulisan provinsi
        INITCAP(BTRIM(provinsi)) AS provinsi,

        -- Mengubah koordinat menjadi numeric
        CAST(NULLIF(BTRIM(lat), '') AS NUMERIC) AS lat,
        CAST(NULLIF(BTRIM(lon), '') AS NUMERIC) AS lon,

        -- Membersihkan populasi dan mengubah ke integer
        CASE
            WHEN REPLACE(BTRIM(populasi), '.', '') ~ '^[0-9]+$'
            THEN CAST(REPLACE(BTRIM(populasi), '.', '') AS INTEGER)
            ELSE NULL
        END AS populasi,

        sumber,

        -- Mengubah tanggal menjadi tipe DATE
        CAST(updated_at AS DATE) AS updated_at

    FROM datamentah_kecamatan
),

data_urut AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY kode
            ORDER BY updated_at DESC, id DESC
        ) AS nomor
    FROM data_bersih
)

-- Mengambil satu data terbaru untuk setiap kode
SELECT
    id,
    kode,
    nama,
    kabupaten,
    provinsi,
    lat,
    lon,
    populasi,
    sumber,
    updated_at
FROM data_urut
WHERE nomor = 1;

SELECT * from cleans_kecamatan

---Validasi koordinat
-- Membuat tabel status koordinat hasil validasi
ALTER TABLE cleans_kecamatan
ADD COLUMN coord_status VARCHAR(20);

-- Membuat algoritma validasi data koordinat
UPDATE cleans_kecamatan
SET coord_status =
    CASE
        WHEN lat IS NULL OR lon IS NULL
            THEN 'missing'

        WHEN lat BETWEEN 95 AND 141
         AND lon BETWEEN -11 AND 6
            THEN 'swapped'

        WHEN lat BETWEEN -11 AND 6
         AND lon BETWEEN 95 AND 141
            THEN 'ok'

        ELSE 'out_of_range'
    END;
	
-- Menampilkan data beserta hasil validasinya
SELECT
    kode,
    nama,
    lat,
    lon,
    coord_status
FROM cleans_kecamatan;

-- Menghitung jumlah data berdasarkan status validasi
SELECT
    coord_status,
    COUNT(*) AS jumlah
FROM cleans_kecamatan
GROUP BY coord_status;

-- Membuat tabel data yang bermasalah
CREATE TABLE data_issue AS
SELECT
    kode,
    coord_status AS jenis_masalah,

    CASE
        WHEN coord_status = 'missing'
            THEN 'Latitude atau longitude kosong'

        WHEN coord_status = 'swapped'
            THEN 'Koordinat tertukar'

        WHEN coord_status = 'out_of_range'
            THEN 'Koordinat berada di luar rentang wilayah Indonesia'

    END AS keterangan

FROM cleans_kecamatan
WHERE coord_status <> 'ok';
select * from data_issue

-- Membuat tabel data hasil validasi
CREATE TABLE validasi_kecamatan AS
SELECT *
FROM cleans_kecamatan;

-- Memperbaiki nilai koordinat yang tertukar antara latitude dan longitude
UPDATE validasi_kecamatan
SET
    lat = lon,
    lon = lat
WHERE coord_status = 'swapped';

--Mengupdate status data validasi
UPDATE validasi_kecamatan
SET coord_status = 'ok'
WHERE coord_status = 'swapped';

---Membuat geojson
CREATE VIEW v_kecamatan_geojson AS
SELECT json_build_object(
    'type', 'FeatureCollection',
    'features', json_agg(
        json_build_object(
            'type', 'Feature',
            'geometry', json_build_object(
                'type', 'Point',
                'coordinates', json_build_array(lon, lat)
            ),
            'properties', json_build_object(
                'kode', kode,
                'nama', nama,
                'kabupaten', kabupaten,
                'provinsi', provinsi,
                'populasi', populasi
            )
        )
    )
) AS geojson
FROM validasi_kecamatan
WHERE coord_status = 'ok'
AND lat IS NOT NULL
AND lon IS NOT NULL;

- Membuat geojson
CREATE OR REPLACE VIEW v_kecamatan_geojson AS
SELECT json_build_object(
    'type', 'FeatureCollection',

    'features', json_agg(
        json_build_object(
            'type', 'Feature',

            'geometry', json_build_object(
                'type', 'Point',
                'coordinates', json_build_array(lon, lat)
            ),

            'properties', json_build_object(
                'kode', kode,
                'nama', nama,
                'kabupaten', kabupaten,
                'provinsi', provinsi,
                'populasi', populasi
            )
        )
    )
) AS geojson

FROM validasi_kecamatan

WHERE coord_status = 'ok'
  AND lat IS NOT NULL
  AND lon IS NOT NULL;

--Menampilkan geojson
SELECT *
FROM v_kecamatan_geojson;

-- Memastikan jumlah fitur
SELECT jsonb_array_length(
    geojson::jsonb -> 'features'
) AS jumlah_fitur
FROM v_kecamatan_geojson;


select * from validasi_kecamatan where coord_status = 'ok'
