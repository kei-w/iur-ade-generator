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
-- ur_noteattribute 
-- -------------------------------------------------------------------- 
ALTER TABLE ur_noteattribute
    DROP CONSTRAINT ur_noteattri_building_mi_fk;

ALTER TABLE ur_noteattribute
    DROP CONSTRAINT ur_noteattri_detailattr_fk;

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

-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
-- *********************************** Drop Sequences ************************************* 
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 

DROP SEQUENCE ur_baseattribute_seq;

DROP SEQUENCE ur_detailattribute_seq;

DROP SEQUENCE ur_extraattribute_seq;

DROP SEQUENCE ur_noteattribute_seq;

