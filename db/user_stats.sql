CREATE MATERIALIZED VIEW user_stats AS
  SELECT
    user_id,
    sum(road_km_added) road_km_added,
    sum(road_km_modified) road_km_modified,
    sum(waterway_km_added) waterway_km_added,
    sum(waterway_km_modified) waterway_km_modified,
    sum(roads_added) roads_added,
    sum(roads_modified) roads_modified,
    sum(waterways_added) waterways_added,
    sum(waterways_modified) waterways_modified,
    sum(buildings_added) buildings_added,
    sum(buildings_modified) buildings_modified,
    sum(pois_added) pois_added,
    sum(pois_modified) pois_modified,
    sum(CASE
      WHEN array_length(regexp_match(editor, '(?i)josm'), 1) > 0 THEN 1
      ELSE 0
      END) josm_edits,
    max(coalesce(closed_at, created_at)) updated_at
  FROM changesets2
  GROUP BY user_id;

CREATE UNIQUE INDEX user_stats_user_id ON user_stats(user_id);
