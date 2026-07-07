-- =============================================================================
-- Layer 3: SEL Profiles — Tam-Taro AIOStreams SEL-inspired
-- Generated: 2026-07-06
--
-- Three profiles that translate the Tam-Taro AIOStreams SEL filtering/sorting
-- philosophy into Radarr/Sonarr quality profiles:
--   SEL Movies  (Radarr)  — 2160p Remux ceiling, 1080p fallback
--   SEL TV      (Sonarr)  — same + Season Pack bonus
--   SEL Anime   (Sonarr)  — same + Anime Dual Audio preference
--
-- Quality ladder (all profiles):
--   Remux-2160p (ceiling) > 2160p group (Bluray/WEB-DL/WEBRip/HDTV) >
--   Remux-1080p > 1080p group (Bluray/WEB-DL/WEBRip/HDTV) > [disabled below]
--
-- CF scoring reflects SEL priority order:
--   HDR: DV > HDR10+ > HDR
--   Audio: Atmos > DTS:X > TrueHD > DTS-HD MA > FLAC > DTS-HD HRA > DTS-ES >
--          DTS > DD+ > DD > AAC
--   Groups: Baseline > BHDStudio / hallowed > WEB Scene
--   Hard blocks: 3D, AI upscale, BR-DISK, LQ groups/titles (-10,000)
--
-- To re-apply after an upstream sync without _sources/:
--   # Remove old Layer 3 block first (everything after PRAGMA foreign_keys = ON)
--   # Then: cat ops/1.sel-profiles.sql >> ops/0.merged-snapshot.sql
-- =============================================================================

-- quality_profiles: 3 rows
INSERT OR IGNORE INTO "quality_profiles" ("name","description","upgrades_allowed","minimum_custom_format_score","upgrade_until_score","upgrade_score_increment") VALUES ('SEL Movies','Tam-Taro AIOStreams SEL-inspired profile for movies. Prioritises Remux > Bluray > WEB-DL > WEBRip at 2160p with 1080p fallback. Audio scored per SEL order (Atmos > DTS:X > TrueHD > DTS-HD MA). HDR/DV preferred. Excludes 3D, AI upscales and LQ groups.',1,0,10000,1);
INSERT OR IGNORE INTO "quality_profiles" ("name","description","upgrades_allowed","minimum_custom_format_score","upgrade_until_score","upgrade_score_increment") VALUES ('SEL TV','Tam-Taro AIOStreams SEL-inspired profile for TV series. Same quality/audio/HDR preferences as SEL Movies. Bonus for Season Packs.',1,0,10000,1);
INSERT OR IGNORE INTO "quality_profiles" ("name","description","upgrades_allowed","minimum_custom_format_score","upgrade_until_score","upgrade_score_increment") VALUES ('SEL Anime','Tam-Taro AIOStreams SEL-inspired profile for anime. Prefers Dual Audio (Japanese + English) and trusted anime groups. Same quality/audio/HDR preferences as SEL Movies.',1,0,10000,1);

-- quality_groups: 2 per profile = 6 rows
INSERT OR IGNORE INTO "quality_groups" ("quality_profile_name","name") VALUES ('SEL Movies','2160p');
INSERT OR IGNORE INTO "quality_groups" ("quality_profile_name","name") VALUES ('SEL Movies','1080p');
INSERT OR IGNORE INTO "quality_groups" ("quality_profile_name","name") VALUES ('SEL TV','2160p');
INSERT OR IGNORE INTO "quality_groups" ("quality_profile_name","name") VALUES ('SEL TV','1080p');
INSERT OR IGNORE INTO "quality_groups" ("quality_profile_name","name") VALUES ('SEL Anime','2160p');
INSERT OR IGNORE INTO "quality_groups" ("quality_profile_name","name") VALUES ('SEL Anime','1080p');

-- quality_group_members: 4 per group × 2 groups × 3 profiles = 24 rows
-- Group members are ordered Bluray > WEBDL > WEBRip > HDTV (SEL quality preference).
-- Within a group Radarr uses CF scores to pick between available releases.
-- SEL Movies
INSERT OR IGNORE INTO "quality_group_members" ("quality_profile_name","quality_group_name","quality_name","position") VALUES ('SEL Movies','2160p','Bluray-2160p',0);
INSERT OR IGNORE INTO "quality_group_members" ("quality_profile_name","quality_group_name","quality_name","position") VALUES ('SEL Movies','2160p','WEBDL-2160p',1);
INSERT OR IGNORE INTO "quality_group_members" ("quality_profile_name","quality_group_name","quality_name","position") VALUES ('SEL Movies','2160p','WEBRip-2160p',2);
INSERT OR IGNORE INTO "quality_group_members" ("quality_profile_name","quality_group_name","quality_name","position") VALUES ('SEL Movies','2160p','HDTV-2160p',3);
INSERT OR IGNORE INTO "quality_group_members" ("quality_profile_name","quality_group_name","quality_name","position") VALUES ('SEL Movies','1080p','Bluray-1080p',0);
INSERT OR IGNORE INTO "quality_group_members" ("quality_profile_name","quality_group_name","quality_name","position") VALUES ('SEL Movies','1080p','WEBDL-1080p',1);
INSERT OR IGNORE INTO "quality_group_members" ("quality_profile_name","quality_group_name","quality_name","position") VALUES ('SEL Movies','1080p','WEBRip-1080p',2);
INSERT OR IGNORE INTO "quality_group_members" ("quality_profile_name","quality_group_name","quality_name","position") VALUES ('SEL Movies','1080p','HDTV-1080p',3);
-- SEL TV
INSERT OR IGNORE INTO "quality_group_members" ("quality_profile_name","quality_group_name","quality_name","position") VALUES ('SEL TV','2160p','Bluray-2160p',0);
INSERT OR IGNORE INTO "quality_group_members" ("quality_profile_name","quality_group_name","quality_name","position") VALUES ('SEL TV','2160p','WEBDL-2160p',1);
INSERT OR IGNORE INTO "quality_group_members" ("quality_profile_name","quality_group_name","quality_name","position") VALUES ('SEL TV','2160p','WEBRip-2160p',2);
INSERT OR IGNORE INTO "quality_group_members" ("quality_profile_name","quality_group_name","quality_name","position") VALUES ('SEL TV','2160p','HDTV-2160p',3);
INSERT OR IGNORE INTO "quality_group_members" ("quality_profile_name","quality_group_name","quality_name","position") VALUES ('SEL TV','1080p','Bluray-1080p',0);
INSERT OR IGNORE INTO "quality_group_members" ("quality_profile_name","quality_group_name","quality_name","position") VALUES ('SEL TV','1080p','WEBDL-1080p',1);
INSERT OR IGNORE INTO "quality_group_members" ("quality_profile_name","quality_group_name","quality_name","position") VALUES ('SEL TV','1080p','WEBRip-1080p',2);
INSERT OR IGNORE INTO "quality_group_members" ("quality_profile_name","quality_group_name","quality_name","position") VALUES ('SEL TV','1080p','HDTV-1080p',3);
-- SEL Anime
INSERT OR IGNORE INTO "quality_group_members" ("quality_profile_name","quality_group_name","quality_name","position") VALUES ('SEL Anime','2160p','Bluray-2160p',0);
INSERT OR IGNORE INTO "quality_group_members" ("quality_profile_name","quality_group_name","quality_name","position") VALUES ('SEL Anime','2160p','WEBDL-2160p',1);
INSERT OR IGNORE INTO "quality_group_members" ("quality_profile_name","quality_group_name","quality_name","position") VALUES ('SEL Anime','2160p','WEBRip-2160p',2);
INSERT OR IGNORE INTO "quality_group_members" ("quality_profile_name","quality_group_name","quality_name","position") VALUES ('SEL Anime','2160p','HDTV-2160p',3);
INSERT OR IGNORE INTO "quality_group_members" ("quality_profile_name","quality_group_name","quality_name","position") VALUES ('SEL Anime','1080p','Bluray-1080p',0);
INSERT OR IGNORE INTO "quality_group_members" ("quality_profile_name","quality_group_name","quality_name","position") VALUES ('SEL Anime','1080p','WEBDL-1080p',1);
INSERT OR IGNORE INTO "quality_group_members" ("quality_profile_name","quality_group_name","quality_name","position") VALUES ('SEL Anime','1080p','WEBRip-1080p',2);
INSERT OR IGNORE INTO "quality_group_members" ("quality_profile_name","quality_group_name","quality_name","position") VALUES ('SEL Anime','1080p','HDTV-1080p',3);

-- quality_profile_qualities: 25 rows per profile = 75 rows
-- Columns: quality_profile_name, quality_name, quality_group_name, position, enabled, upgrade_until
-- pos 0  Remux-2160p  — individual, enabled, upgrade_until=1 (ceiling)
-- pos 1  2160p group  — enabled
-- pos 2  Remux-1080p  — individual, enabled
-- pos 3  1080p group  — enabled
-- pos 4-24: all disabled
-- SEL Movies
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL Movies','Remux-2160p',NULL,0,1,1);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL Movies',NULL,'2160p',1,1,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL Movies','Remux-1080p',NULL,2,1,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL Movies',NULL,'1080p',3,1,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL Movies','Bluray-720p',NULL,4,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL Movies','WEBDL-720p',NULL,5,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL Movies','WEBRip-720p',NULL,6,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL Movies','Bluray-480p',NULL,7,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL Movies','Bluray-576p',NULL,8,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL Movies','BR-DISK',NULL,9,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL Movies','CAM',NULL,10,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL Movies','DVD',NULL,11,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL Movies','DVD-R',NULL,12,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL Movies','DVDSCR',NULL,13,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL Movies','HDTV-480p',NULL,14,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL Movies','HDTV-720p',NULL,15,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL Movies','Raw-HD',NULL,16,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL Movies','REGIONAL',NULL,17,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL Movies','SDTV',NULL,18,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL Movies','TELECINE',NULL,19,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL Movies','TELESYNC',NULL,20,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL Movies','Unknown',NULL,21,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL Movies','WEBDL-480p',NULL,22,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL Movies','WEBRip-480p',NULL,23,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL Movies','WORKPRINT',NULL,24,0,0);
-- SEL TV
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL TV','Remux-2160p',NULL,0,1,1);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL TV',NULL,'2160p',1,1,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL TV','Remux-1080p',NULL,2,1,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL TV',NULL,'1080p',3,1,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL TV','Bluray-720p',NULL,4,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL TV','WEBDL-720p',NULL,5,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL TV','WEBRip-720p',NULL,6,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL TV','Bluray-480p',NULL,7,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL TV','Bluray-576p',NULL,8,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL TV','BR-DISK',NULL,9,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL TV','CAM',NULL,10,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL TV','DVD',NULL,11,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL TV','DVD-R',NULL,12,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL TV','DVDSCR',NULL,13,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL TV','HDTV-480p',NULL,14,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL TV','HDTV-720p',NULL,15,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL TV','Raw-HD',NULL,16,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL TV','REGIONAL',NULL,17,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL TV','SDTV',NULL,18,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL TV','TELECINE',NULL,19,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL TV','TELESYNC',NULL,20,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL TV','Unknown',NULL,21,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL TV','WEBDL-480p',NULL,22,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL TV','WEBRip-480p',NULL,23,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL TV','WORKPRINT',NULL,24,0,0);
-- SEL Anime
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL Anime','Remux-2160p',NULL,0,1,1);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL Anime',NULL,'2160p',1,1,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL Anime','Remux-1080p',NULL,2,1,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL Anime',NULL,'1080p',3,1,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL Anime','Bluray-720p',NULL,4,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL Anime','WEBDL-720p',NULL,5,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL Anime','WEBRip-720p',NULL,6,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL Anime','Bluray-480p',NULL,7,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL Anime','Bluray-576p',NULL,8,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL Anime','BR-DISK',NULL,9,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL Anime','CAM',NULL,10,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL Anime','DVD',NULL,11,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL Anime','DVD-R',NULL,12,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL Anime','DVDSCR',NULL,13,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL Anime','HDTV-480p',NULL,14,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL Anime','HDTV-720p',NULL,15,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL Anime','Raw-HD',NULL,16,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL Anime','REGIONAL',NULL,17,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL Anime','SDTV',NULL,18,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL Anime','TELECINE',NULL,19,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL Anime','TELESYNC',NULL,20,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL Anime','Unknown',NULL,21,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL Anime','WEBDL-480p',NULL,22,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL Anime','WEBRip-480p',NULL,23,0,0);
INSERT OR IGNORE INTO "quality_profile_qualities" ("quality_profile_name","quality_name","quality_group_name","position","enabled","upgrade_until") VALUES ('SEL Anime','WORKPRINT',NULL,24,0,0);

-- quality_profile_languages: 3 rows (Any language, simple mode)
INSERT OR IGNORE INTO "quality_profile_languages" ("quality_profile_name","language_name","type") VALUES ('SEL Movies','Any','simple');
INSERT OR IGNORE INTO "quality_profile_languages" ("quality_profile_name","language_name","type") VALUES ('SEL TV','Any','simple');
INSERT OR IGNORE INTO "quality_profile_languages" ("quality_profile_name","language_name","type") VALUES ('SEL Anime','Any','simple');

-- quality_profile_custom_formats
-- Columns: quality_profile_name, custom_format_name, arr_type, score
--
-- Score design mirrors SEL's priority ordering:
--   HDR:     DV=600, HDR10+=400, HDR=200
--   Audio:   Atmos=400, DTS:X=350, TrueHD=300, DTS-HD MA=250, FLAC=200,
--            DTS-HD HRA=150, DTS-ES=100, DTS=75, DD+=50, DD=25, AAC=10
--   Groups:  Baseline=500, BHDStudio/hallowed=200, WEB Scene=100
--   Service: MA=75, IMAX/DSNP/iT/CRIT/Special Edition=50,
--            4K Remaster/Remaster/ATVP/HMAX/MAX/BCORE=25, AMZN/NF=10
--   Repacks: Repack3=7, Repack2=6, Repack1=5
--   Blocks:  3D / Upscaled / BR-DISK / Extras / B&W / Sing Along /
--            Accessibility / Fake HDR / HONE Bad Name / AV1 /
--            Dumpstarr LQ Groups / Dumpstarr LQ Title = -10,000

-- ── SEL Movies (Radarr) ──────────────────────────────────────────────────────
-- HDR / video
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Movies','Dolby Vision [Dumpstarr]','radarr',600);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Movies','HDR10+ [Dumpstarr]','radarr',400);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Movies','HDR [Dumpstarr]','radarr',200);
-- Audio
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Movies','Atmos [Dumpstarr]','radarr',400);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Movies','DTS-X [Dumpstarr]','radarr',350);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Movies','TrueHD [Dumpstarr]','radarr',300);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Movies','DTS-HD MA [Dumpstarr]','radarr',250);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Movies','FLAC','radarr',200);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Movies','DTS-HD HRA [Dumpstarr]','radarr',150);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Movies','DTS-ES [Dumpstarr]','radarr',100);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Movies','DTS [Dumpstarr]','radarr',75);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Movies','Dolby Digital +','radarr',50);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Movies','Dolby Digital [Dumpstarr]','radarr',25);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Movies','AAC [Dumpstarr]','radarr',10);
-- Release groups
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Movies','Baseline Groups','radarr',500);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Movies','BHDStudio','radarr',200);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Movies','hallowed','radarr',200);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Movies','WEB Scene','radarr',100);
-- Streaming source quality signals
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Movies','MA [Dumpstarr]','radarr',75);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Movies','IMAX [Dumpstarr]','radarr',50);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Movies','IMAX Enhanced [Dumpstarr]','radarr',50);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Movies','DSNP [Dumpstarr]','radarr',50);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Movies','iT [Dumpstarr]','radarr',50);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Movies','CRIT [Dumpstarr]','radarr',50);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Movies','Special Edition [Dumpstarr]','radarr',50);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Movies','4K Remaster','radarr',25);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Movies','Remaster','radarr',25);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Movies','ATVP [Dumpstarr]','radarr',25);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Movies','HMAX [Dumpstarr]','radarr',25);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Movies','MAX [Dumpstarr]','radarr',25);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Movies','BCORE [Dumpstarr]','radarr',25);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Movies','AMZN [Dumpstarr]','radarr',10);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Movies','NF [Dumpstarr]','radarr',10);
-- Repacks
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Movies','Repack3 [Dumpstarr]','radarr',7);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Movies','Repack2 [Dumpstarr]','radarr',6);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Movies','Repack1 [Dumpstarr]','radarr',5);
-- Hard blocks (-10,000 ensures score < minimum_custom_format_score=0 → release rejected)
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Movies','3D [Dumpstarr]','radarr',-10000);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Movies','Upscaled','radarr',-10000);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Movies','BR-DISK','radarr',-10000);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Movies','Extras [Dumpstarr]','radarr',-10000);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Movies','B&W [Dumpstarr]','radarr',-10000);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Movies','Sing Along [Dumpstarr]','radarr',-10000);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Movies','Accessibility','radarr',-10000);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Movies','Fake HDR','radarr',-10000);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Movies','HONE (Bad Name)','radarr',-10000);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Movies','AV1','radarr',-10000);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Movies','Dumpstarr LQ Groups','radarr',-10000);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Movies','Dumpstarr LQ Title','radarr',-10000);

-- ── SEL TV (Sonarr) ──────────────────────────────────────────────────────────
-- HDR / video
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL TV','Dolby Vision [Dumpstarr]','sonarr',600);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL TV','HDR10+ [Dumpstarr]','sonarr',400);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL TV','HDR [Dumpstarr]','sonarr',200);
-- Audio
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL TV','Atmos [Dumpstarr]','sonarr',400);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL TV','DTS-X [Dumpstarr]','sonarr',350);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL TV','TrueHD [Dumpstarr]','sonarr',300);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL TV','DTS-HD MA [Dumpstarr]','sonarr',250);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL TV','FLAC','sonarr',200);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL TV','DTS-HD HRA [Dumpstarr]','sonarr',150);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL TV','DTS-ES [Dumpstarr]','sonarr',100);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL TV','DTS [Dumpstarr]','sonarr',75);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL TV','Dolby Digital +','sonarr',50);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL TV','Dolby Digital [Dumpstarr]','sonarr',25);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL TV','AAC [Dumpstarr]','sonarr',10);
-- Release groups
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL TV','Baseline Groups','sonarr',500);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL TV','BHDStudio','sonarr',200);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL TV','hallowed','sonarr',200);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL TV','WEB Scene','sonarr',100);
-- Streaming source quality signals
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL TV','MA [Dumpstarr]','sonarr',75);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL TV','IMAX [Dumpstarr]','sonarr',50);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL TV','IMAX Enhanced [Dumpstarr]','sonarr',50);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL TV','DSNP [Dumpstarr]','sonarr',50);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL TV','iT [Dumpstarr]','sonarr',50);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL TV','CRIT [Dumpstarr]','sonarr',50);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL TV','Special Edition [Dumpstarr]','sonarr',50);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL TV','4K Remaster','sonarr',25);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL TV','Remaster','sonarr',25);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL TV','ATVP [Dumpstarr]','sonarr',25);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL TV','HMAX [Dumpstarr]','sonarr',25);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL TV','MAX [Dumpstarr]','sonarr',25);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL TV','BCORE [Dumpstarr]','sonarr',25);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL TV','AMZN [Dumpstarr]','sonarr',10);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL TV','NF [Dumpstarr]','sonarr',10);
-- Season Pack bonus (Sonarr only)
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL TV','Season Pack','sonarr',10);
-- Repacks
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL TV','Repack3 [Dumpstarr]','sonarr',7);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL TV','Repack2 [Dumpstarr]','sonarr',6);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL TV','Repack1 [Dumpstarr]','sonarr',5);
-- Hard blocks
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL TV','3D [Dumpstarr]','sonarr',-10000);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL TV','Upscaled','sonarr',-10000);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL TV','BR-DISK','sonarr',-10000);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL TV','Extras [Dumpstarr]','sonarr',-10000);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL TV','B&W [Dumpstarr]','sonarr',-10000);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL TV','Sing Along [Dumpstarr]','sonarr',-10000);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL TV','Accessibility','sonarr',-10000);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL TV','Fake HDR','sonarr',-10000);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL TV','HONE (Bad Name)','sonarr',-10000);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL TV','AV1','sonarr',-10000);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL TV','Dumpstarr LQ Groups','sonarr',-10000);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL TV','Dumpstarr LQ Title','sonarr',-10000);

-- ── SEL Anime (Sonarr) ───────────────────────────────────────────────────────
-- Uses Anime-specific group CFs instead of the live-action BHDStudio/hallowed.
-- HDR / video
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Anime','Dolby Vision [Dumpstarr]','sonarr',600);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Anime','HDR10+ [Dumpstarr]','sonarr',400);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Anime','HDR [Dumpstarr]','sonarr',200);
-- Audio
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Anime','Atmos [Dumpstarr]','sonarr',400);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Anime','DTS-X [Dumpstarr]','sonarr',350);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Anime','TrueHD [Dumpstarr]','sonarr',300);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Anime','DTS-HD MA [Dumpstarr]','sonarr',250);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Anime','FLAC','sonarr',200);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Anime','DTS-HD HRA [Dumpstarr]','sonarr',150);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Anime','DTS-ES [Dumpstarr]','sonarr',100);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Anime','DTS [Dumpstarr]','sonarr',75);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Anime','Dolby Digital +','sonarr',50);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Anime','Dolby Digital [Dumpstarr]','sonarr',25);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Anime','AAC [Dumpstarr]','sonarr',10);
-- Anime-specific release groups (replaces BHDStudio/hallowed for anime)
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Anime','Anime Baseline Groups','sonarr',500);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Anime','Baseline Groups','sonarr',200);
-- Dual Audio preference (SEL ISE protects dual audio; we score it here)
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Anime','Anime Dual Audio','sonarr',300);
-- Streaming source quality signals
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Anime','MA [Dumpstarr]','sonarr',75);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Anime','IMAX [Dumpstarr]','sonarr',50);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Anime','IMAX Enhanced [Dumpstarr]','sonarr',50);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Anime','DSNP [Dumpstarr]','sonarr',50);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Anime','iT [Dumpstarr]','sonarr',50);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Anime','CRIT [Dumpstarr]','sonarr',50);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Anime','Special Edition [Dumpstarr]','sonarr',50);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Anime','4K Remaster','sonarr',25);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Anime','Remaster','sonarr',25);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Anime','ATVP [Dumpstarr]','sonarr',25);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Anime','HMAX [Dumpstarr]','sonarr',25);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Anime','MAX [Dumpstarr]','sonarr',25);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Anime','BCORE [Dumpstarr]','sonarr',25);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Anime','AMZN [Dumpstarr]','sonarr',10);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Anime','NF [Dumpstarr]','sonarr',10);
-- Season Pack bonus (Sonarr only)
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Anime','Season Pack','sonarr',10);
-- Repacks
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Anime','Repack3 [Dumpstarr]','sonarr',7);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Anime','Repack2 [Dumpstarr]','sonarr',6);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Anime','Repack1 [Dumpstarr]','sonarr',5);
-- Hard blocks
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Anime','3D [Dumpstarr]','sonarr',-10000);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Anime','Upscaled','sonarr',-10000);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Anime','BR-DISK','sonarr',-10000);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Anime','Extras [Dumpstarr]','sonarr',-10000);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Anime','B&W [Dumpstarr]','sonarr',-10000);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Anime','Sing Along [Dumpstarr]','sonarr',-10000);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Anime','Accessibility','sonarr',-10000);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Anime','Fake HDR','sonarr',-10000);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Anime','HONE (Bad Name)','sonarr',-10000);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Anime','AV1','sonarr',-10000);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Anime','Banned Dual Audio Groups','sonarr',-10000);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Anime','Dumpstarr LQ Groups','sonarr',-10000);
INSERT OR IGNORE INTO "quality_profile_custom_formats" ("quality_profile_name","custom_format_name","arr_type","score") VALUES ('SEL Anime','Dumpstarr LQ Title','sonarr',-10000);
