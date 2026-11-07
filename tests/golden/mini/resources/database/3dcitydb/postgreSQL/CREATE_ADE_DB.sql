-- This document was automatically created by the ADE-Manager tool of 3DCityDB (https://www.3dcitydb.org) (mini ADE) 
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
-- *********************************** Create Sequences *********************************** 
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 

CREATE SEQUENCE ur_baseattribute_seq
INCREMENT BY 1
MINVALUE 0
MAXVALUE 9223372036854775807
START WITH 1
CACHE 1
NO CYCLE
OWNED BY NONE;


CREATE SEQUENCE ur_detailattribute_seq
INCREMENT BY 1
MINVALUE 0
MAXVALUE 9223372036854775807
START WITH 1
CACHE 1
NO CYCLE
OWNED BY NONE;


CREATE SEQUENCE ur_extraattribute_seq
INCREMENT BY 1
MINVALUE 0
MAXVALUE 9223372036854775807
START WITH 1
CACHE 1
NO CYCLE
OWNED BY NONE;


CREATE SEQUENCE ur_noteattribute_seq
INCREMENT BY 1
MINVALUE 0
MAXVALUE 9223372036854775807
START WITH 1
CACHE 1
NO CYCLE
OWNED BY NONE;


-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
-- *********************************** Create tables ************************************** 
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 

-- -------------------------------------------------------------------- 
-- ur_baseattribute 
-- -------------------------------------------------------------------- 
CREATE TABLE ur_baseattribute
(
    id BIGINT NOT NULL DEFAULT nextval('ur_baseattribute_seq'::regclass) NOT NULL,
    basefield VARCHAR(1000),
    objectclass_id INTEGER,
    subfield INTEGER,
    PRIMARY KEY (id)
);

-- -------------------------------------------------------------------- 
-- ur_building 
-- -------------------------------------------------------------------- 
CREATE TABLE ur_building
(
    id BIGINT NOT NULL,
    minidetailattribute_id BIGINT,
    PRIMARY KEY (id)
);

-- -------------------------------------------------------------------- 
-- ur_detailattribute 
-- -------------------------------------------------------------------- 
CREATE TABLE ur_detailattribute
(
    id BIGINT NOT NULL DEFAULT nextval('ur_detailattribute_seq'::regclass) NOT NULL,
    area NUMERIC,
    area_uom VARCHAR(1000),
    base_id BIGINT,
    color VARCHAR(1000),
    count INTEGER,
    date_ TIMESTAMP WITH TIME ZONE,
    extra_id BIGINT,
    geometry_id BIGINT,
    grade VARCHAR(1000),
    kind VARCHAR(1000),
    kind_codespace VARCHAR(1000),
    name VARCHAR(1000),
    tags VARCHAR(1000),
    PRIMARY KEY (id)
);

-- -------------------------------------------------------------------- 
-- ur_extraattribute 
-- -------------------------------------------------------------------- 
CREATE TABLE ur_extraattribute
(
    id BIGINT NOT NULL DEFAULT nextval('ur_extraattribute_seq'::regclass) NOT NULL,
    value_ VARCHAR(1000),
    PRIMARY KEY (id)
);

-- -------------------------------------------------------------------- 
-- ur_minifeature 
-- -------------------------------------------------------------------- 
CREATE TABLE ur_minifeature
(
    id BIGINT NOT NULL,
    detail_id BIGINT,
    label VARCHAR(1000),
    lod1multisurface_id BIGINT,
    PRIMARY KEY (id)
);

-- -------------------------------------------------------------------- 
-- ur_minipart 
-- -------------------------------------------------------------------- 
CREATE TABLE ur_minipart
(
    id BIGINT NOT NULL,
    minifeature_part_id BIGINT,
    partname VARCHAR(1000),
    PRIMARY KEY (id)
);

-- -------------------------------------------------------------------- 
-- ur_noteattribute 
-- -------------------------------------------------------------------- 
CREATE TABLE ur_noteattribute
(
    id BIGINT NOT NULL DEFAULT nextval('ur_noteattribute_seq'::regclass) NOT NULL,
    text VARCHAR(1000),
    PRIMARY KEY (id)
);

-- -------------------------------------------------------------------- 
-- ur_detailatt_to_noteattri 
-- -------------------------------------------------------------------- 
CREATE TABLE ur_detailatt_to_noteattri
(
    noteattribute_id BIGINT NOT NULL,
    detailattribute_id BIGINT NOT NULL,
    PRIMARY KEY (noteattribute_id, detailattribute_id)
);

-- -------------------------------------------------------------------- 
-- ur_building_to_noteattri 
-- -------------------------------------------------------------------- 
CREATE TABLE ur_building_to_noteattri
(
    noteattribute_id BIGINT NOT NULL,
    building_id BIGINT NOT NULL,
    PRIMARY KEY (noteattribute_id, building_id)
);

-- -------------------------------------------------------------------- 
-- ur_abstractm_to_cityobjec 
-- -------------------------------------------------------------------- 
CREATE TABLE ur_abstractm_to_cityobjec
(
    abstractminifunction_id BIGINT NOT NULL,
    cityobject_id BIGINT NOT NULL,
    PRIMARY KEY (cityobject_id, abstractminifunction_id)
);

-- -------------------------------------------------------------------- 
-- ur_abstractminifunction 
-- -------------------------------------------------------------------- 
CREATE TABLE ur_abstractminifunction
(
    id BIGINT NOT NULL,
    function VARCHAR(1000),
    function_codespace VARCHAR(1000),
    lod1multisurface_id BIGINT,
    objectclass_id INTEGER,
    validfrom TIMESTAMP WITH TIME ZONE,
    PRIMARY KEY (id)
);

-- -------------------------------------------------------------------- 
-- ur_minizone 
-- -------------------------------------------------------------------- 
CREATE TABLE ur_minizone
(
    id BIGINT NOT NULL,
    areainha NUMERIC,
    areainha_uom VARCHAR(1000),
    detail_id BIGINT,
    PRIMARY KEY (id)
);

-- -------------------------------------------------------------------- 
-- ur_minizone_to_minizone 
-- -------------------------------------------------------------------- 
CREATE TABLE ur_minizone_to_minizone
(
    minizone_id BIGINT NOT NULL,
    minizone_id_2 BIGINT NOT NULL,
    PRIMARY KEY (minizone_id_2, minizone_id)
);

-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
-- *********************************** Create foreign keys ******************************** 
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 

-- -------------------------------------------------------------------- 
-- ur_baseattribute 
-- -------------------------------------------------------------------- 
ALTER TABLE ur_baseattribute ADD CONSTRAINT ur_baseattribute_objectclass_fk FOREIGN KEY (objectclass_id)
REFERENCES objectclass (id);

-- -------------------------------------------------------------------- 
-- ur_building 
-- -------------------------------------------------------------------- 
ALTER TABLE ur_building ADD CONSTRAINT ur_building_fk FOREIGN KEY (id)
REFERENCES cityobject (id)
ON DELETE CASCADE;

ALTER TABLE ur_building ADD CONSTRAINT ur_building_minidetail_fk FOREIGN KEY (minidetailattribute_id)
REFERENCES ur_detailattribute (id)
ON DELETE SET NULL;

-- -------------------------------------------------------------------- 
-- ur_detailattribute 
-- -------------------------------------------------------------------- 
ALTER TABLE ur_detailattribute ADD CONSTRAINT ur_detailattri_base_fk FOREIGN KEY (base_id)
REFERENCES ur_baseattribute (id)
ON DELETE SET NULL;

ALTER TABLE ur_detailattribute ADD CONSTRAINT ur_detailattri_extra_fk FOREIGN KEY (extra_id)
REFERENCES ur_extraattribute (id)
ON DELETE SET NULL;

ALTER TABLE ur_detailattribute ADD CONSTRAINT ur_detailattri_geometry_fk FOREIGN KEY (geometry_id)
REFERENCES surface_geometry (id);

-- -------------------------------------------------------------------- 
-- ur_minifeature 
-- -------------------------------------------------------------------- 
ALTER TABLE ur_minifeature ADD CONSTRAINT ur_minifeature_fk FOREIGN KEY (id)
REFERENCES cityobject (id)
ON DELETE CASCADE;

ALTER TABLE ur_minifeature ADD CONSTRAINT ur_minifeature_detail_fk FOREIGN KEY (detail_id)
REFERENCES ur_detailattribute (id)
ON DELETE SET NULL;

ALTER TABLE ur_minifeature ADD CONSTRAINT ur_minifeature_lod1msrf_fk FOREIGN KEY (lod1multisurface_id)
REFERENCES surface_geometry (id);

-- -------------------------------------------------------------------- 
-- ur_minipart 
-- -------------------------------------------------------------------- 
ALTER TABLE ur_minipart ADD CONSTRAINT ur_minipart_fk FOREIGN KEY (id)
REFERENCES cityobject (id)
ON DELETE CASCADE;

ALTER TABLE ur_minipart ADD CONSTRAINT ur_minipart_minifeatu_part_fk FOREIGN KEY (minifeature_part_id)
REFERENCES ur_minifeature (id);

-- -------------------------------------------------------------------- 
-- ur_noteattribute 
-- -------------------------------------------------------------------- 
-- -------------------------------------------------------------------- 
-- ur_detailatt_to_noteattri 
-- -------------------------------------------------------------------- 
ALTER TABLE ur_detailatt_to_noteattri ADD CONSTRAINT ur_detailatt_noteattribu_fk FOREIGN KEY (noteattribute_id)
REFERENCES ur_noteattribute (id)
ON DELETE CASCADE;

ALTER TABLE ur_detailatt_to_noteattri ADD CONSTRAINT ur_detailatt_detailattri_fk FOREIGN KEY (detailattribute_id)
REFERENCES ur_detailattribute (id)
ON DELETE CASCADE;

-- -------------------------------------------------------------------- 
-- ur_building_to_noteattri 
-- -------------------------------------------------------------------- 
ALTER TABLE ur_building_to_noteattri ADD CONSTRAINT ur_building__noteattribu_fk FOREIGN KEY (noteattribute_id)
REFERENCES ur_noteattribute (id)
ON DELETE CASCADE;

ALTER TABLE ur_building_to_noteattri ADD CONSTRAINT ur_building__building_id_fk FOREIGN KEY (building_id)
REFERENCES ur_building (id)
ON DELETE CASCADE;

-- -------------------------------------------------------------------- 
-- ur_abstractm_to_cityobjec 
-- -------------------------------------------------------------------- 
ALTER TABLE ur_abstractm_to_cityobjec ADD CONSTRAINT ur_abstractm_abstractmin_fk FOREIGN KEY (abstractminifunction_id)
REFERENCES ur_abstractminifunction (id)
ON DELETE CASCADE;

ALTER TABLE ur_abstractm_to_cityobjec ADD CONSTRAINT ur_abstractm_cityobject__fk FOREIGN KEY (cityobject_id)
REFERENCES cityobject (id)
ON DELETE CASCADE;

-- -------------------------------------------------------------------- 
-- ur_abstractminifunction 
-- -------------------------------------------------------------------- 
ALTER TABLE ur_abstractminifunction ADD CONSTRAINT ur_abstractmini_objectclass_fk FOREIGN KEY (objectclass_id)
REFERENCES objectclass (id);

ALTER TABLE ur_abstractminifunction ADD CONSTRAINT ur_abstractminifunction_fk FOREIGN KEY (id)
REFERENCES cityobject (id)
ON DELETE CASCADE;

ALTER TABLE ur_abstractminifunction ADD CONSTRAINT ur_abstractm_lod1multisu_fk FOREIGN KEY (lod1multisurface_id)
REFERENCES surface_geometry (id);

-- -------------------------------------------------------------------- 
-- ur_minizone 
-- -------------------------------------------------------------------- 
ALTER TABLE ur_minizone ADD CONSTRAINT ur_minizone_fk FOREIGN KEY (id)
REFERENCES ur_abstractminifunction (id)
ON DELETE CASCADE;

ALTER TABLE ur_minizone ADD CONSTRAINT ur_minizone_detail_id_fk FOREIGN KEY (detail_id)
REFERENCES ur_detailattribute (id)
ON DELETE SET NULL;

-- -------------------------------------------------------------------- 
-- ur_minizone_to_minizone 
-- -------------------------------------------------------------------- 
ALTER TABLE ur_minizone_to_minizone ADD CONSTRAINT ur_minizone__minizone_id_fk FOREIGN KEY (minizone_id)
REFERENCES ur_minizone (id)
ON DELETE CASCADE;

ALTER TABLE ur_minizone_to_minizone ADD CONSTRAINT ur_minizone__minizone_id_fk_2 FOREIGN KEY (minizone_id_2)
REFERENCES ur_minizone (id)
ON DELETE CASCADE;

-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
-- *********************************** Create Indexes ************************************* 
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 

-- -------------------------------------------------------------------- 
-- ur_baseattribute 
-- -------------------------------------------------------------------- 
CREATE INDEX ur_baseattrib_objectcla_fkx ON ur_baseattribute
    USING btree
    (
      objectclass_id ASC NULLS LAST
    )   WITH (FILLFACTOR = 90);

-- -------------------------------------------------------------------- 
-- ur_building 
-- -------------------------------------------------------------------- 
CREATE INDEX ur_building_minidetail_fkx ON ur_building
    USING btree
    (
      minidetailattribute_id ASC NULLS LAST
    )   WITH (FILLFACTOR = 90);

-- -------------------------------------------------------------------- 
-- ur_detailattribute 
-- -------------------------------------------------------------------- 
CREATE INDEX ur_detailattri_base_fkx ON ur_detailattribute
    USING btree
    (
      base_id ASC NULLS LAST
    )   WITH (FILLFACTOR = 90);

CREATE INDEX ur_detailattri_extra_fkx ON ur_detailattribute
    USING btree
    (
      extra_id ASC NULLS LAST
    )   WITH (FILLFACTOR = 90);

CREATE INDEX ur_detailattri_geometry_fkx ON ur_detailattribute
    USING btree
    (
      geometry_id ASC NULLS LAST
    )   WITH (FILLFACTOR = 90);

-- -------------------------------------------------------------------- 
-- ur_minifeature 
-- -------------------------------------------------------------------- 
CREATE INDEX ur_minifeature_detail_fkx ON ur_minifeature
    USING btree
    (
      detail_id ASC NULLS LAST
    )   WITH (FILLFACTOR = 90);

CREATE INDEX ur_minifeature_lod1msrf_fkx ON ur_minifeature
    USING btree
    (
      lod1multisurface_id ASC NULLS LAST
    )   WITH (FILLFACTOR = 90);

-- -------------------------------------------------------------------- 
-- ur_minipart 
-- -------------------------------------------------------------------- 
CREATE INDEX ur_minipart_minifeatu_fkx ON ur_minipart
    USING btree
    (
      minifeature_part_id ASC NULLS LAST
    )   WITH (FILLFACTOR = 90);

-- -------------------------------------------------------------------- 
-- ur_noteattribute 
-- -------------------------------------------------------------------- 
-- -------------------------------------------------------------------- 
-- ur_detailatt_to_noteattri 
-- -------------------------------------------------------------------- 
CREATE INDEX ur_detailatt_noteattrib_fkx ON ur_detailatt_to_noteattri
    USING btree
    (
      noteattribute_id ASC NULLS LAST
    )   WITH (FILLFACTOR = 90);

CREATE INDEX ur_detailatt_detailattr_fkx ON ur_detailatt_to_noteattri
    USING btree
    (
      detailattribute_id ASC NULLS LAST
    )   WITH (FILLFACTOR = 90);

-- -------------------------------------------------------------------- 
-- ur_building_to_noteattri 
-- -------------------------------------------------------------------- 
CREATE INDEX ur_building__noteattrib_fkx ON ur_building_to_noteattri
    USING btree
    (
      noteattribute_id ASC NULLS LAST
    )   WITH (FILLFACTOR = 90);

CREATE INDEX ur_building__building_i_fkx ON ur_building_to_noteattri
    USING btree
    (
      building_id ASC NULLS LAST
    )   WITH (FILLFACTOR = 90);

-- -------------------------------------------------------------------- 
-- ur_abstractminifunction 
-- -------------------------------------------------------------------- 
CREATE INDEX ur_abstractm_lod1multis_fkx ON ur_abstractminifunction
    USING btree
    (
      lod1multisurface_id ASC NULLS LAST
    )   WITH (FILLFACTOR = 90);

CREATE INDEX ur_abstractm_objectclas_fkx ON ur_abstractminifunction
    USING btree
    (
      objectclass_id ASC NULLS LAST
    )   WITH (FILLFACTOR = 90);

-- -------------------------------------------------------------------- 
-- ur_minizone 
-- -------------------------------------------------------------------- 
CREATE INDEX ur_minizone_detail_id_fkx ON ur_minizone
    USING btree
    (
      detail_id ASC NULLS LAST
    )   WITH (FILLFACTOR = 90);

