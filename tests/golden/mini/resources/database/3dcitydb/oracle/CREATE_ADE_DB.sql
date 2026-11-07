-- This document was automatically created by the ADE-Manager tool of 3DCityDB (https://www.3dcitydb.org) (mini ADE)
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- *********************************** Create Sequences ***********************************
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

CREATE SEQUENCE ur_baseattribute_seq INCREMENT BY 1 START WITH 1 MINVALUE 1 CACHE 10000;

CREATE SEQUENCE ur_detailattribute_seq INCREMENT BY 1 START WITH 1 MINVALUE 1 CACHE 10000;

CREATE SEQUENCE ur_extraattribute_seq INCREMENT BY 1 START WITH 1 MINVALUE 1 CACHE 10000;

CREATE SEQUENCE ur_noteattribute_seq INCREMENT BY 1 START WITH 1 MINVALUE 1 CACHE 10000;

-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- *********************************** Create tables **************************************
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- --------------------------------------------------------------------
-- ur_baseattribute
-- --------------------------------------------------------------------
CREATE TABLE ur_baseattribute
(
    id NUMBER(38) NOT NULL,
    basefield VARCHAR2(1000),
    objectclass_id INTEGER,
    subfield INTEGER,
    PRIMARY KEY (id)
);

-- --------------------------------------------------------------------
-- ur_building
-- --------------------------------------------------------------------
CREATE TABLE ur_building
(
    id NUMBER(38) NOT NULL,
    minidetailattribute_id NUMBER(38),
    PRIMARY KEY (id)
);

-- --------------------------------------------------------------------
-- ur_detailattribute
-- --------------------------------------------------------------------
CREATE TABLE ur_detailattribute
(
    id NUMBER(38) NOT NULL,
    area NUMBER,
    area_uom VARCHAR2(1000),
    base_id NUMBER(38),
    color VARCHAR2(1000),
    count INTEGER,
    date_ TIMESTAMP,
    extra_id NUMBER(38),
    geometry_id NUMBER(38),
    grade VARCHAR2(1000),
    kind VARCHAR2(1000),
    kind_codespace VARCHAR2(1000),
    name VARCHAR2(1000),
    tags VARCHAR2(1000),
    PRIMARY KEY (id)
);

-- --------------------------------------------------------------------
-- ur_extraattribute
-- --------------------------------------------------------------------
CREATE TABLE ur_extraattribute
(
    id NUMBER(38) NOT NULL,
    value_ VARCHAR2(1000),
    PRIMARY KEY (id)
);

-- --------------------------------------------------------------------
-- ur_minifeature
-- --------------------------------------------------------------------
CREATE TABLE ur_minifeature
(
    id NUMBER(38) NOT NULL,
    detail_id NUMBER(38),
    label VARCHAR2(1000),
    lod1multisurface_id NUMBER(38),
    PRIMARY KEY (id)
);

-- --------------------------------------------------------------------
-- ur_minipart
-- --------------------------------------------------------------------
CREATE TABLE ur_minipart
(
    id NUMBER(38) NOT NULL,
    minifeature_part_id NUMBER(38),
    partname VARCHAR2(1000),
    PRIMARY KEY (id)
);

-- --------------------------------------------------------------------
-- ur_noteattribute
-- --------------------------------------------------------------------
CREATE TABLE ur_noteattribute
(
    id NUMBER(38) NOT NULL,
    text VARCHAR2(1000),
    PRIMARY KEY (id)
);

-- --------------------------------------------------------------------
-- ur_detailatt_to_noteattri
-- --------------------------------------------------------------------
CREATE TABLE ur_detailatt_to_noteattri
(
    noteattribute_id NUMBER(38) NOT NULL,
    detailattribute_id NUMBER(38) NOT NULL,
    PRIMARY KEY (noteattribute_id, detailattribute_id)
);

-- --------------------------------------------------------------------
-- ur_building_to_noteattri
-- --------------------------------------------------------------------
CREATE TABLE ur_building_to_noteattri
(
    noteattribute_id NUMBER(38) NOT NULL,
    building_id NUMBER(38) NOT NULL,
    PRIMARY KEY (noteattribute_id, building_id)
);

-- --------------------------------------------------------------------
-- ur_abstractm_to_cityobjec
-- --------------------------------------------------------------------
CREATE TABLE ur_abstractm_to_cityobjec
(
    abstractminifunction_id NUMBER(38) NOT NULL,
    cityobject_id NUMBER(38) NOT NULL,
    PRIMARY KEY (cityobject_id, abstractminifunction_id)
);

-- --------------------------------------------------------------------
-- ur_abstractminifunction
-- --------------------------------------------------------------------
CREATE TABLE ur_abstractminifunction
(
    id NUMBER(38) NOT NULL,
    function VARCHAR2(1000),
    function_codespace VARCHAR2(1000),
    lod1multisurface_id NUMBER(38),
    objectclass_id INTEGER,
    validfrom TIMESTAMP,
    PRIMARY KEY (id)
);

-- --------------------------------------------------------------------
-- ur_minizone
-- --------------------------------------------------------------------
CREATE TABLE ur_minizone
(
    id NUMBER(38) NOT NULL,
    areainha NUMBER,
    areainha_uom VARCHAR2(1000),
    detail_id NUMBER(38),
    PRIMARY KEY (id)
);

-- --------------------------------------------------------------------
-- ur_minizone_to_minizone
-- --------------------------------------------------------------------
CREATE TABLE ur_minizone_to_minizone
(
    minizone_id NUMBER(38) NOT NULL,
    minizone_id_2 NUMBER(38) NOT NULL,
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
ALTER TABLE ur_detailatt_to_noteattri ADD CONSTRAINT ur_detailatt_noteattribu_fk_2 FOREIGN KEY (noteattribute_id)
REFERENCES ur_noteattribute (id)
ON DELETE CASCADE;

ALTER TABLE ur_detailatt_to_noteattri ADD CONSTRAINT ur_detailatt_detailattri_fk_2 FOREIGN KEY (detailattribute_id)
REFERENCES ur_detailattribute (id)
ON DELETE CASCADE;

-- --------------------------------------------------------------------
-- ur_building_to_noteattri
-- --------------------------------------------------------------------
ALTER TABLE ur_building_to_noteattri ADD CONSTRAINT ur_building__noteattribu_fk_2 FOREIGN KEY (noteattribute_id)
REFERENCES ur_noteattribute (id)
ON DELETE CASCADE;

ALTER TABLE ur_building_to_noteattri ADD CONSTRAINT ur_building__building_id_fk_2 FOREIGN KEY (building_id)
REFERENCES ur_building (id)
ON DELETE CASCADE;

-- --------------------------------------------------------------------
-- ur_abstractm_to_cityobjec
-- --------------------------------------------------------------------
ALTER TABLE ur_abstractm_to_cityobjec ADD CONSTRAINT ur_abstractm_abstractmin_fk_2 FOREIGN KEY (abstractminifunction_id)
REFERENCES ur_abstractminifunction (id)
ON DELETE CASCADE;

ALTER TABLE ur_abstractm_to_cityobjec ADD CONSTRAINT ur_abstractm_cityobject__fk_2 FOREIGN KEY (cityobject_id)
REFERENCES cityobject (id)
ON DELETE CASCADE;

-- --------------------------------------------------------------------
-- ur_abstractminifunction
-- --------------------------------------------------------------------
ALTER TABLE ur_abstractminifunction ADD CONSTRAINT ur_abstractmini_objectclass__2 FOREIGN KEY (objectclass_id)
REFERENCES objectclass (id);

ALTER TABLE ur_abstractminifunction ADD CONSTRAINT ur_abstractminifunction_fk_2 FOREIGN KEY (id)
REFERENCES cityobject (id)
ON DELETE CASCADE;

ALTER TABLE ur_abstractminifunction ADD CONSTRAINT ur_abstractm_lod1multisu_fk_2 FOREIGN KEY (lod1multisurface_id)
REFERENCES surface_geometry (id);

-- --------------------------------------------------------------------
-- ur_minizone
-- --------------------------------------------------------------------
ALTER TABLE ur_minizone ADD CONSTRAINT ur_minizone_fk_2 FOREIGN KEY (id)
REFERENCES ur_abstractminifunction (id)
ON DELETE CASCADE;

ALTER TABLE ur_minizone ADD CONSTRAINT ur_minizone_detail_id_fk_2 FOREIGN KEY (detail_id)
REFERENCES ur_detailattribute (id)
ON DELETE SET NULL;

-- --------------------------------------------------------------------
-- ur_minizone_to_minizone
-- --------------------------------------------------------------------
ALTER TABLE ur_minizone_to_minizone ADD CONSTRAINT ur_minizone__minizone_id_fk_3 FOREIGN KEY (minizone_id)
REFERENCES ur_minizone (id)
ON DELETE CASCADE;

ALTER TABLE ur_minizone_to_minizone ADD CONSTRAINT ur_minizone__minizone_id_fk_4 FOREIGN KEY (minizone_id_2)
REFERENCES ur_minizone (id)
ON DELETE CASCADE;

-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- *********************************** Create Indexes *************************************
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- --------------------------------------------------------------------
-- ur_baseattribute
-- --------------------------------------------------------------------
CREATE INDEX ur_baseattrib_objectcla_fkx ON ur_baseattribute (objectclass_id);

-- --------------------------------------------------------------------
-- ur_building
-- --------------------------------------------------------------------
CREATE INDEX ur_building_minidetail_fkx ON ur_building (minidetailattribute_id);

-- --------------------------------------------------------------------
-- ur_detailattribute
-- --------------------------------------------------------------------
CREATE INDEX ur_detailattri_base_fkx ON ur_detailattribute (base_id);

CREATE INDEX ur_detailattri_extra_fkx ON ur_detailattribute (extra_id);

CREATE INDEX ur_detailattri_geometry_fkx ON ur_detailattribute (geometry_id);

-- --------------------------------------------------------------------
-- ur_minifeature
-- --------------------------------------------------------------------
CREATE INDEX ur_minifeature_detail_fkx ON ur_minifeature (detail_id);

CREATE INDEX ur_minifeature_lod1msrf_fkx ON ur_minifeature (lod1multisurface_id);

-- --------------------------------------------------------------------
-- ur_minipart
-- --------------------------------------------------------------------
CREATE INDEX ur_minipart_minifeatu_fkx ON ur_minipart (minifeature_part_id);

-- --------------------------------------------------------------------
-- ur_noteattribute
-- --------------------------------------------------------------------
-- --------------------------------------------------------------------
-- ur_detailatt_to_noteattri
-- --------------------------------------------------------------------
CREATE INDEX ur_detailatt_noteattrib_fkx_2 ON ur_detailatt_to_noteattri (noteattribute_id);

CREATE INDEX ur_detailatt_detailattr_fkx_2 ON ur_detailatt_to_noteattri (detailattribute_id);

-- --------------------------------------------------------------------
-- ur_building_to_noteattri
-- --------------------------------------------------------------------
CREATE INDEX ur_building__noteattrib_fkx_2 ON ur_building_to_noteattri (noteattribute_id);

CREATE INDEX ur_building__building_i_fkx_2 ON ur_building_to_noteattri (building_id);

-- --------------------------------------------------------------------
-- ur_abstractminifunction
-- --------------------------------------------------------------------
CREATE INDEX ur_abstractm_lod1multis_fkx_2 ON ur_abstractminifunction (lod1multisurface_id);

CREATE INDEX ur_abstractm_objectclas_fkx_2 ON ur_abstractminifunction (objectclass_id);

-- --------------------------------------------------------------------
-- ur_minizone
-- --------------------------------------------------------------------
CREATE INDEX ur_minizone_detail_id_fkx_2 ON ur_minizone (detail_id);
