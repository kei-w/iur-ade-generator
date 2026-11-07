-- This document was automatically created by the ADE-Manager tool of 3DCityDB (https://www.3dcitydb.org) (mini ADE)
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- *********************************** Drop foreign keys **********************************
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- --------------------------------------------------------------------
-- ur_baseattribute
-- --------------------------------------------------------------------
ALTER TABLE ur_baseattribute
    DROP CONSTRAINT ur_baseattribute_objectclass_fk;

-- --------------------------------------------------------------------
-- ur_building
-- --------------------------------------------------------------------
ALTER TABLE ur_building
    DROP CONSTRAINT ur_building_fk;

ALTER TABLE ur_building
    DROP CONSTRAINT ur_building_minidetail_fk;

-- --------------------------------------------------------------------
-- ur_building_to_noteattri
-- --------------------------------------------------------------------
ALTER TABLE ur_building_to_noteattri
    DROP CONSTRAINT ur_building__noteattribu_fk_2;

ALTER TABLE ur_building_to_noteattri
    DROP CONSTRAINT ur_building__building_id_fk_2;

-- --------------------------------------------------------------------
-- ur_detailatt_to_noteattri
-- --------------------------------------------------------------------
ALTER TABLE ur_detailatt_to_noteattri
    DROP CONSTRAINT ur_detailatt_noteattribu_fk_2;

ALTER TABLE ur_detailatt_to_noteattri
    DROP CONSTRAINT ur_detailatt_detailattri_fk_2;

-- --------------------------------------------------------------------
-- ur_detailattribute
-- --------------------------------------------------------------------
ALTER TABLE ur_detailattribute
    DROP CONSTRAINT ur_detailattri_base_fk;

ALTER TABLE ur_detailattribute
    DROP CONSTRAINT ur_detailattri_extra_fk;

ALTER TABLE ur_detailattribute
    DROP CONSTRAINT ur_detailattri_geometry_fk;

-- --------------------------------------------------------------------
-- ur_minifeature
-- --------------------------------------------------------------------
ALTER TABLE ur_minifeature
    DROP CONSTRAINT ur_minifeature_fk;

ALTER TABLE ur_minifeature
    DROP CONSTRAINT ur_minifeature_detail_fk;

ALTER TABLE ur_minifeature
    DROP CONSTRAINT ur_minifeature_lod1msrf_fk;

-- --------------------------------------------------------------------
-- ur_minipart
-- --------------------------------------------------------------------
ALTER TABLE ur_minipart
    DROP CONSTRAINT ur_minipart_fk;

ALTER TABLE ur_minipart
    DROP CONSTRAINT ur_minipart_minifeatu_part_fk;

-- --------------------------------------------------------------------
-- ur_abstractm_to_cityobjec
-- --------------------------------------------------------------------
ALTER TABLE ur_abstractm_to_cityobjec
    DROP CONSTRAINT ur_abstractm_abstractmin_fk_2;

ALTER TABLE ur_abstractm_to_cityobjec
    DROP CONSTRAINT ur_abstractm_cityobject__fk_2;

-- --------------------------------------------------------------------
-- ur_abstractminifunction
-- --------------------------------------------------------------------
ALTER TABLE ur_abstractminifunction
    DROP CONSTRAINT ur_abstractmini_objectclass__2;

ALTER TABLE ur_abstractminifunction
    DROP CONSTRAINT ur_abstractminifunction_fk_2;

ALTER TABLE ur_abstractminifunction
    DROP CONSTRAINT ur_abstractm_lod1multisu_fk_2;

-- --------------------------------------------------------------------
-- ur_minizone
-- --------------------------------------------------------------------
ALTER TABLE ur_minizone
    DROP CONSTRAINT ur_minizone_fk_2;

ALTER TABLE ur_minizone
    DROP CONSTRAINT ur_minizone_detail_id_fk_2;

-- --------------------------------------------------------------------
-- ur_minizone_to_minizone
-- --------------------------------------------------------------------
ALTER TABLE ur_minizone_to_minizone
    DROP CONSTRAINT ur_minizone__minizone_id_fk_3;

ALTER TABLE ur_minizone_to_minizone
    DROP CONSTRAINT ur_minizone__minizone_id_fk_4;

-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- *********************************** Drop tables ***************************************
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- --------------------------------------------------------------------
-- ur_baseattribute
-- --------------------------------------------------------------------
DROP TABLE ur_baseattribute;

-- --------------------------------------------------------------------
-- ur_building
-- --------------------------------------------------------------------
DROP TABLE ur_building;

-- --------------------------------------------------------------------
-- ur_building_to_noteattri
-- --------------------------------------------------------------------
DROP TABLE ur_building_to_noteattri;

-- --------------------------------------------------------------------
-- ur_detailatt_to_noteattri
-- --------------------------------------------------------------------
DROP TABLE ur_detailatt_to_noteattri;

-- --------------------------------------------------------------------
-- ur_detailattribute
-- --------------------------------------------------------------------
DROP TABLE ur_detailattribute;

-- --------------------------------------------------------------------
-- ur_extraattribute
-- --------------------------------------------------------------------
DROP TABLE ur_extraattribute;

-- --------------------------------------------------------------------
-- ur_minifeature
-- --------------------------------------------------------------------
DROP TABLE ur_minifeature;

-- --------------------------------------------------------------------
-- ur_minipart
-- --------------------------------------------------------------------
DROP TABLE ur_minipart;

-- --------------------------------------------------------------------
-- ur_noteattribute
-- --------------------------------------------------------------------
DROP TABLE ur_noteattribute;

-- --------------------------------------------------------------------
-- ur_abstractm_to_cityobjec
-- --------------------------------------------------------------------
DROP TABLE ur_abstractm_to_cityobjec;

-- --------------------------------------------------------------------
-- ur_abstractminifunction
-- --------------------------------------------------------------------
DROP TABLE ur_abstractminifunction;

-- --------------------------------------------------------------------
-- ur_minizone
-- --------------------------------------------------------------------
DROP TABLE ur_minizone;

-- --------------------------------------------------------------------
-- ur_minizone_to_minizone
-- --------------------------------------------------------------------
DROP TABLE ur_minizone_to_minizone;

-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- *********************************** Drop Sequences *************************************
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

DROP SEQUENCE ur_baseattribute_seq;

DROP SEQUENCE ur_detailattribute_seq;

DROP SEQUENCE ur_extraattribute_seq;

DROP SEQUENCE ur_noteattribute_seq;
