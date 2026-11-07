-- Automatically generated database script (Creation Date: 2026-11-07 20:53:13)
-- FUNCTION citydb.cleanup_appearances(only_global INTEGER DEFAULT 1) RETURNS SETOF bigint
-- FUNCTION citydb.cleanup_schema() RETURNS SETOF void
-- FUNCTION citydb.cleanup_table(tab_name TEXT) RETURNS SETOF bigint
-- FUNCTION citydb.del_address(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_address(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_appearance(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_appearance(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_breakline_relief(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_breakline_relief(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_bridge(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_bridge(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_bridge_constr_element(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_bridge_constr_element(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_bridge_furniture(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_bridge_furniture(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_bridge_installation(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_bridge_installation(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_bridge_opening(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_bridge_opening(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_bridge_room(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_bridge_room(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_bridge_thematic_surface(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_bridge_thematic_surface(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_building(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_building(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_building_furniture(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_building_furniture(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_building_installation(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_building_installation(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_city_furniture(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_city_furniture(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_citymodel(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_citymodel(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_cityobject(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_cityobject(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_cityobject_genericattrib(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_cityobject_genericattrib(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_cityobjectgroup(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_cityobjectgroup(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_cityobjects_by_lineage(lineage_value TEXT, objectclass_id INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_external_reference(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_external_reference(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_generic_cityobject(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_generic_cityobject(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_grid_coverage(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_grid_coverage(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_implicit_geometry(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_implicit_geometry(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_land_use(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_land_use(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_masspoint_relief(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_masspoint_relief(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_opening(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_opening(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_plant_cover(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_plant_cover(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_raster_relief(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_raster_relief(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_relief_component(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_relief_component(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_relief_feature(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_relief_feature(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_room(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_room(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_solitary_vegetat_object(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_solitary_vegetat_object(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_surface_data(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_surface_data(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_surface_geometry(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_surface_geometry(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_tex_image(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_tex_image(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_thematic_surface(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_thematic_surface(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_tin_relief(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_tin_relief(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_traffic_area(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_traffic_area(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_transportation_complex(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_transportation_complex(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_tunnel(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_tunnel(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_tunnel_furniture(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_tunnel_furniture(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_tunnel_hollow_space(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_tunnel_hollow_space(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_tunnel_installation(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_tunnel_installation(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_tunnel_opening(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_tunnel_opening(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_tunnel_thematic_surface(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_tunnel_thematic_surface(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_abstractdistrictplan(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_abstractdistrictplan(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_administration(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_administration(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_agency(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_agency(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_agreement(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_agreement(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_agriculturaldevelopmen(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_agriculturaldevelopmen(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_areaclassification(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_areaclassification(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_areaofannualdiversions(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_areaofannualdiversions(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_attribution(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_attribution(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_boundary(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_boundary(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_boundarysurface(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_boundarysurface(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_breakdownofnominalarea(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_breakdownofnominalarea(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_bridge(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_bridge(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_bridgefunctionalattrib(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_bridgefunctionalattrib(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_bridgestructureattribu(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_bridgestructureattribu(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_building(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_building(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_building_furniture(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_building_furniture(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_building_installation(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_building_installation(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_buildingattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_buildingattribute(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_buildingdetailattribut(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_buildingdetailattribut(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_buildingidattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_buildingidattribute(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_buildingusecaseattribu(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_buildingusecaseattribu(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_cable(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_cable(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_calendar(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_calendar(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_calendardate(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_calendardate(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_cargohandlingfacility(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_cargohandlingfacility(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_censusblock(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_censusblock(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_circularcurvetype(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_circularcurvetype(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_city_furniture(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_city_furniture(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_cityfurnitureattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_cityfurnitureattribute(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_cityobject(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_cityobject(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_cityobjectgroup(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_cityobjectgroup(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_cityobjectgroup_1(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_cityobjectgroup_1(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_cityobjectgroup_2(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_cityobjectgroup_2(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_cityobjectgroup_3(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_cityobjectgroup_3(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_collectivefacilities_2(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_collectivefacilities_2(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_collectivefacilities_3(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_collectivefacilities_3(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_collectivefacilitiesfo(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_collectivefacilitiesfo(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_collectivegovernmentan(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_collectivegovernmentan(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_collectivehousingfacil(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_collectivehousingfacil(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_collectiveurbandisaste(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_collectiveurbandisaste(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_construction(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_construction(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_constructionbaseattrib(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_constructionbaseattrib(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_constructionevent(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_constructionevent(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_constructioninstallati(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_constructioninstallati(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_constructionriskassess(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_constructionriskassess(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_constructionstructurea(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_constructionstructurea(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_controlpoint(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_controlpoint(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_controlpointtype(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_controlpointtype(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_countermeasurescost(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_countermeasurescost(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_crs(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_crs(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_cyberportmarinaandpbs(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_cyberportmarinaandpbs(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_damattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_damattribute(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_dataqualityattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_dataqualityattribute(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_daytimepopulationtype(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_daytimepopulationtype(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_description(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_description(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_developmentproject(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_developmentproject(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_did(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_did(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_disasterdamage(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_disasterdamage(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_disasterpreventionbase(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_disasterpreventionbase(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_disasterpreventionbl_2(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_disasterpreventionbl_2(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_disasterpreventionbloc(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_disasterpreventionbloc(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_disasterriskattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_disasterriskattribute(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_distributionbusinesspa(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_distributionbusinesspa(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_distributionbusinesszo(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_distributionbusinesszo(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_district(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_district(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_districtdevelopmentpla(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_districtdevelopmentpla(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_districtplan(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_districtplan(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_districtsandzones(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_districtsandzones(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_dmannotation(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_dmannotation(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_dmattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_dmattribute(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_dmelement(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_dmelement(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_dmgeometricattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_dmgeometricattribute(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_economicactivitysumtyp(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_economicactivitysumtyp(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_economicactivitytype(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_economicactivitytype(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_elevation(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_elevation(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_embankmentattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_embankmentattribute(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_exceptionalfloorareara(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_exceptionalfloorareara(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_facilityattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_facilityattribute(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_facilityidattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_facilityidattribute(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_facilitytypeattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_facilitytypeattribute(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_fareattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_fareattribute(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_farerule(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_farerule(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_farmlandconversiontype(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_farmlandconversiontype(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_feedinfo(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_feedinfo(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_fishingportattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_fishingportattribute(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_fishingportcapacity(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_fishingportcapacity(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_fishingportfacility(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_fishingportfacility(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_floodingriskattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_floodingriskattribute(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_forestconversiontype(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_forestconversiontype(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_frequency(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_frequency(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_globalhubcitydevelopme(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_globalhubcitydevelopme(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_harborfacility(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_harborfacility(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_height(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_height(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_heightcontroldistrict(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_heightcontroldistrict(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_highlevelusedistrict(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_highlevelusedistrict(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_highriseresidentialatt(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_highriseresidentialatt(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_historicscenerymainten(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_historicscenerymainten(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_households(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_households(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_ifcattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_ifcattribute(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_ifcbuilding(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_ifcbuilding(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_ifcbuildingelement(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_ifcbuildingelement(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_ifcclassification(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_ifcclassification(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_ifcclassificationrefer(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_ifcclassificationrefer(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_ifccoordinatereference(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_ifccoordinatereference(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_ifcdoor(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_ifcdoor(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_ifcelement(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_ifcelement(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_ifcgeometricrepresenta(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_ifcgeometricrepresenta(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_ifcmapconversion(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_ifcmapconversion(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_ifcopeningelement(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_ifcopeningelement(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_ifcproduct(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_ifcproduct(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_ifcproject(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_ifcproject(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_ifcprojectedcrs(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_ifcprojectedcrs(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_ifcpsetbuildingcommon(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_ifcpsetbuildingcommon(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_ifcpsetdoorcommon(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_ifcpsetdoorcommon(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_ifcpsetopeningelementc(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_ifcpsetopeningelementc(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_ifcpsetsitecommon(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_ifcpsetsitecommon(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_ifcpsetspacecommon(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_ifcpsetspacecommon(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_ifcpsetwindowcommon(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_ifcpsetwindowcommon(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_ifcroot(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_ifcroot(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_ifcsite(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_ifcsite(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_ifcspace(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_ifcspace(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_ifcspacebasequantity(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_ifcspacebasequantity(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_ifcspatialstructureele(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_ifcspatialstructureele(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_ifcunit(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_ifcunit(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_ifcwall(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_ifcwall(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_ifcwindow(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_ifcwindow(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_indoorattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_indoorattribute(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_indoorfacilityattribut(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_indoorfacilityattribut(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_indoorspaceattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_indoorspaceattribute(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_indoorstoreyattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_indoorstoreyattribute(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_indoortactiletileattri(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_indoortactiletileattri(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_indooruserdefinedattri(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_indooruserdefinedattri(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_industrialparkdevelopm(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_industrialparkdevelopm(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_itemrecordtype(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_itemrecordtype(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_keyvaluepair(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_keyvaluepair(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_keyvaluepairattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_keyvaluepairattribute(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_land_use(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_land_use(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_landprice(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_landprice(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_landprice_2(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_landprice_2(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_landpriceperlanduse(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_landpriceperlanduse(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_landreadjustmentprojec(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_landreadjustmentprojec(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_landscapezone(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_landscapezone(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_landuseattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_landuseattribute(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_landusediversion(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_landusediversion(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_landusediversion_2(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_landusediversion_2(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_largecustomerfacilitya(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_largecustomerfacilitya(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_lengthattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_lengthattribute(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_longevitymeasures(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_longevitymeasures(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_maintenancehistoryattr(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_maintenancehistoryattr(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_mooringfacility(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_mooringfacility(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_navigationassistancefa(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_navigationassistancefa(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_newhousing(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_newhousing(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_newhousingandurbandeve(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_newhousingandurbandeve(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_newurbaninfrastructure(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_newurbaninfrastructure(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_numberofannualdiversio(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_numberofannualdiversio(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_numberoffacilities(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_numberoffacilities(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_numberofhouseholds(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_numberofhouseholds(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_observationpoint(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_observationpoint(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_occupancy(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_occupancy(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_office(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_office(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_officesandemployees(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_officesandemployees(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_offsetdepth(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_offsetdepth(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_opening(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_opening(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_openspaceforpublicuse(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_openspaceforpublicuse(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_otherconstruction(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_otherconstruction(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_parkattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_parkattribute(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_parkfacilitylongevityp(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_parkfacilitylongevityp(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_parkhealthassessment(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_parkhealthassessment(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_parkingplaceattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_parkingplaceattribute(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_pathway(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_pathway(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_pipe(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_pipe(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_point(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_point(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_pollution(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_pollution(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_population(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_population(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_populationbyageandsex(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_populationbyageandsex(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_populationbyageandsext(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_populationbyageandsext(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_populationtype(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_populationtype(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_portattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_portattribute(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_portenvironmentalimpro(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_portenvironmentalimpro(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_portmanagementfacility(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_portmanagementfacility(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_portpassengerfacility(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_portpassengerfacility(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_portpollutioncontrolfa(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_portpollutioncontrolfa(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_portprotectivefacility(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_portprotectivefacility(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_portstoragefacility(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_portstoragefacility(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_porttransportationfaci(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_porttransportationfaci(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_portwastetreatmentfaci(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_portwastetreatmentfaci(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_portwelfarefacility(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_portwelfarefacility(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_portzone(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_portzone(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_privateurbanrenewalpro(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_privateurbanrenewalpro(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_productivegreenzone(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_productivegreenzone(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_projectpromotionarea(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_projectpromotionarea(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_publicland(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_publicland(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_publicsurveydataqualit(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_publicsurveydataqualit(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_publictransit(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_publictransit(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_publictransitdatatype(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_publictransitdatatype(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_publictransitfacility(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_publictransitfacility(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_quasiurbanplanningarea(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_quasiurbanplanningarea(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_railwayrouteattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_railwayrouteattribute(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_railwaytrackattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_railwaytrackattribute(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_realestateidattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_realestateidattribute(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_recreations(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_recreations(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_relief_component(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_relief_component(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_relief_feature(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_relief_feature(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_repairsbeforeparkhealt(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_repairsbeforeparkhealt(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_residentialblockconstr(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_residentialblockconstr(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_residentialdevelopment(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_residentialdevelopment(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_residentialenvironment(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_residentialenvironment(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_riverfacilityidattribu(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_riverfacilityidattribu(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_riverfloodingriskattri(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_riverfloodingriskattri(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_roadattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_roadattribute(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_roadsidedistrictimprov(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_roadsidedistrictimprov(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_roadsidedistrictplan(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_roadsidedistrictplan(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_roadstructureattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_roadstructureattribute(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_roadtype(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_roadtype(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_room(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_room(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_route(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_route(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_ruraldistrictimproveme(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_ruraldistrictimproveme(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_scenicdistrict(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_scenicdistrict(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_scenicresource(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_scenicresource(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_scheduledareaforurband(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_scheduledareaforurband(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_sedimentdisasterpronea(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_sedimentdisasterpronea(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_sewerpipe(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_sewerpipe(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_sewersystemattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_sewersystemattribute(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_shipservicefacility(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_shipservicefacility(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_slopetype(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_slopetype(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_specialgreenspaceconse(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_specialgreenspaceconse(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_specialurbanrenaissanc(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_specialurbanrenaissanc(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_specialuseattractiondi(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_specialuseattractiondi(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_specialusedistrict(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_specialusedistrict(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_specialuserestrictiond(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_specialuserestrictiond(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_specifiedblock(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_specifiedblock(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_specifieddisasterpreve(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_specifieddisasterpreve(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_specifiedurgenturbanre(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_specifiedurgenturbanre(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_squareurbanplanattribu(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_squareurbanplanattribu(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_stationsquareattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_stationsquareattribute(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_statisticalgrid(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_statisticalgrid(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_stop(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_stop(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_stoptime(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_stoptime(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_structuredetails(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_structuredetails(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_summaryrecordtype(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_summaryrecordtype(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_supplyfacility(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_supplyfacility(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_terminalattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_terminalattribute(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_thematic_surface(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_thematic_surface(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_thematicshape(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_thematicshape(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_threedimensionalextent(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_threedimensionalextent(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_trackattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_trackattribute(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_traffic_area(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_traffic_area(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_trafficareaattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_trafficareaattribute(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_trafficfacility(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_trafficfacility(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_trafficobjectusecaseat(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_trafficobjectusecaseat(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_trafficvolumeattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_trafficvolumeattribute(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_transfer(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_transfer(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_transitioncurvetype(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_transitioncurvetype(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_translation(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_translation(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_translationjp(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_translationjp(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_transportation_complex(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_transportation_complex(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_treatmentfacility(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_treatmentfacility(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_treeplantingdistrict(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_treeplantingdistrict(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_trip(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_trip(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_tunnel(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_tunnel(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_tunnelfunctionalattrib(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_tunnelfunctionalattrib(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_tunnelstructureattribu(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_tunnelstructureattribu(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_undergroundbuilding(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_undergroundbuilding(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_urbandevelopmentproj_2(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_urbandevelopmentproj_2(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_urbandevelopmentprojec(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_urbandevelopmentprojec(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_urbandisasterrecoveryp(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_urbandisasterrecoveryp(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_urbanfacility(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_urbanfacility(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_urbanfacilitystatus(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_urbanfacilitystatus(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_urbanfacilitystipulate(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_urbanfacilitystipulate(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_urbanfunction(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_urbanfunction(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_urbanization(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_urbanization(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_urbanparkattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_urbanparkattribute(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_urbanplanningarea(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_urbanplanningarea(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_urbanrapidtransitrailr(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_urbanrapidtransitrailr(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_urbanredevelopmentproj(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_urbanredevelopmentproj(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_urbanredevelopmentprom(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_urbanredevelopmentprom(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_urbanrenewalproject(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_urbanrenewalproject(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_urbanroadattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_urbanroadattribute(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_urgenturbanrenewalarea(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_urgenturbanrenewalarea(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_usedistrict(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_usedistrict(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_userdefinedvalue(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_userdefinedvalue(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_utilitylink(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_utilitylink(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_utilitynetworkelement(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_utilitynetworkelement(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_utilitynode(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_utilitynode(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_utilitynodecontainer(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_utilitynodecontainer(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_valuebycodes(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_valuebycodes(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_vehicleterminalattribu(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_vehicleterminalattribu(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_verticalcurvetype(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_verticalcurvetype(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_waterbody(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_waterbody(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_waterbodydetailattribu(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_waterbodydetailattribu(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_waterway(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_waterway(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_waterway_2(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_waterway_2(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_waterwaydetailattribut(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_waterwaydetailattribut(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_waterworksattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_waterworksattribute(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_weatherobservation(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_weatherobservation(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_weatherobservationtype(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_weatherobservationtype(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_zonaldisasterpreventio(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_zonaldisasterpreventio(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_ur_zone(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_ur_zone(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_waterbody(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_waterbody(pid bigint) RETURNS bigint
-- FUNCTION citydb.del_waterboundary_surface(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint
-- FUNCTION citydb.del_waterboundary_surface(pid bigint) RETURNS bigint

------------------------------------------
CREATE OR REPLACE FUNCTION citydb.cleanup_appearances(only_global INTEGER DEFAULT 1) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_id bigint;
  app_id bigint;
BEGIN
  PERFORM citydb.del_surface_data(array_agg(s.id))
    FROM citydb.surface_data s 
    LEFT OUTER JOIN citydb.textureparam t ON s.id = t.surface_data_id
    WHERE t.surface_data_id IS NULL;

    IF only_global=1 THEN
      FOR app_id IN
        SELECT a.id FROM citydb.appearance a
          LEFT OUTER JOIN citydb.appear_to_surface_data asd ON a.id=asd.appearance_id
            WHERE a.cityobject_id IS NULL AND asd.appearance_id IS NULL
      LOOP
        DELETE FROM citydb.appearance WHERE id = app_id RETURNING id INTO deleted_id;
        RETURN NEXT deleted_id;
      END LOOP;
    ELSE
      FOR app_id IN
        SELECT a.id FROM citydb.appearance a
          LEFT OUTER JOIN citydb.appear_to_surface_data asd ON a.id=asd.appearance_id
            WHERE asd.appearance_id IS NULL
      LOOP
        DELETE FROM citydb.appearance WHERE id = app_id RETURNING id INTO deleted_id;
        RETURN NEXT deleted_id;
      END LOOP;
    END IF;

  RETURN;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.cleanup_schema() RETURNS SETOF void AS
$body$
-- Function for cleaning up data schema
DECLARE
  rec RECORD;
BEGIN
  FOR rec IN
    SELECT table_name FROM information_schema.tables where table_schema = 'citydb'
    AND table_name <> 'database_srs'
    AND table_name <> 'objectclass'
    AND table_name <> 'index_table'
    AND table_name <> 'ade'
    AND table_name <> 'schema'
    AND table_name <> 'schema_to_objectclass'
    AND table_name <> 'schema_referencing'
    AND table_name <> 'aggregation_info'
    AND table_name NOT LIKE 'tmp_%'
  LOOP
    EXECUTE format('TRUNCATE TABLE citydb.%I CASCADE', rec.table_name);
  END LOOP;

  FOR rec IN 
    SELECT sequence_name FROM information_schema.sequences where sequence_schema = 'citydb'
    AND sequence_name <> 'ade_seq'
    AND sequence_name <> 'schema_seq'
  LOOP
    EXECUTE format('ALTER SEQUENCE citydb.%I RESTART', rec.sequence_name);	
  END LOOP;
END;
$body$
LANGUAGE plpgsql;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.cleanup_table(tab_name TEXT) RETURNS SETOF bigint AS
$body$
DECLARE
  rec RECORD;
  rec_id bigint;
  where_clause TEXT;
  query_ddl TEXT;
  counter bigint;
  table_alias TEXT;
  table_name_with_schemaprefix TEXT;
  del_func_name TEXT;
  schema_name TEXT;
  deleted_id bigint;
BEGIN
  schema_name = 'citydb';
  IF md5(schema_name) <> '373663016e8a76eedd0e1ac37f392d2a' THEN
    table_name_with_schemaprefix = schema_name || '.' || tab_name;
  ELSE
    table_name_with_schemaprefix = tab_name;
  END IF;

  counter = 0;
  del_func_name = 'del_' || tab_name;
  query_ddl = 'SELECT id FROM ' || schema_name || '.' || tab_name || ' WHERE id IN ('
    || 'SELECT a.id FROM ' || schema_name || '.' || tab_name || ' a';

  FOR rec IN
    SELECT
      c.confrelid::regclass::text AS root_table_name,
      c.conrelid::regclass::text AS fk_table_name,
      a.attname::text AS fk_column_name
    FROM
      pg_constraint c
    JOIN
      pg_attribute a
      ON a.attrelid = c.conrelid
      AND a.attnum = ANY (c.conkey)
    WHERE
      upper(c.confrelid::regclass::text) = upper(table_name_with_schemaprefix)
      AND c.conrelid <> c.confrelid
      AND c.contype = 'f'
    ORDER BY
      fk_table_name,
      fk_column_name
  LOOP
    counter = counter + 1;
    table_alias = 'n' || counter;
    IF counter = 1 THEN
      where_clause = ' WHERE ' || table_alias || '.' || rec.fk_column_name || ' IS NULL';
    ELSE
      where_clause = where_clause || ' AND ' || table_alias || '.' || rec.fk_column_name || ' IS NULL';
    END IF;

    IF md5(schema_name) <> '373663016e8a76eedd0e1ac37f392d2a' THEN
      query_ddl = query_ddl || ' LEFT JOIN ' || rec.fk_table_name || ' ' || table_alias || ' ON '
        || table_alias || '.' || rec.fk_column_name || ' = a.id';
    ELSE
      query_ddl = query_ddl || ' LEFT JOIN ' || schema_name || '.' || rec.fk_table_name || ' ' || table_alias || ' ON '
        || table_alias || '.' || rec.fk_column_name || ' = a.id';
    END IF;
  END LOOP;

  query_ddl = query_ddl || where_clause || ')';

  FOR rec_id IN EXECUTE query_ddl LOOP
    EXECUTE 'SELECT ' || schema_name || '.' || del_func_name || '(' || rec_id || ')' INTO deleted_id;
    RETURN NEXT deleted_id;
  END LOOP;

  RETURN;
END;
$body$
LANGUAGE plpgsql;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_address(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.addresss
  WITH delete_objects AS (
    DELETE FROM
      citydb.address t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_address(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_address(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_appearance(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  surface_data_ids bigint[] := '{}';
BEGIN
  -- delete references to surface_datas
  WITH del_surface_data_refs AS (
    DELETE FROM
      citydb.appear_to_surface_data t
    USING
      unnest($1) a(a_id)
    WHERE
      t.appearance_id = a.a_id
    RETURNING
      t.surface_data_id
  )
  SELECT
    array_agg(surface_data_id)
  INTO
    surface_data_ids
  FROM
    del_surface_data_refs;

  -- delete citydb.surface_data(s)
  IF -1 = ALL(surface_data_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_surface_data(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(surface_data_ids) AS a_id) a
    LEFT JOIN
      citydb.appear_to_surface_data n1
      ON n1.surface_data_id  = a.a_id
    WHERE n1.surface_data_id IS NULL;
  END IF;

  -- delete citydb.appearances
  WITH delete_objects AS (
    DELETE FROM
      citydb.appearance t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_appearance(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_appearance(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_breakline_relief(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.breakline_reliefs
  WITH delete_objects AS (
    DELETE FROM
      citydb.breakline_relief t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete relief_component
    PERFORM citydb.del_relief_component(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_breakline_relief(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_breakline_relief(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_bridge(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  address_ids bigint[] := '{}';
  surface_geometry_ids bigint[] := '{}';
BEGIN
  -- delete referenced parts
  PERFORM
    citydb.del_bridge(array_agg(t.id))
  FROM
    citydb.bridge t,
    unnest($1) a(a_id)
  WHERE
    t.bridge_parent_id = a.a_id
    AND t.id <> a.a_id;

  -- delete referenced parts
  PERFORM
    citydb.del_bridge(array_agg(t.id))
  FROM
    citydb.bridge t,
    unnest($1) a(a_id)
  WHERE
    t.bridge_root_id = a.a_id
    AND t.id <> a.a_id;

  -- delete references to addresss
  WITH del_address_refs AS (
    DELETE FROM
      citydb.address_to_bridge t
    USING
      unnest($1) a(a_id)
    WHERE
      t.bridge_id = a.a_id
    RETURNING
      t.address_id
  )
  SELECT
    array_agg(address_id)
  INTO
    address_ids
  FROM
    del_address_refs;

  -- delete citydb.address(s)
  IF -1 = ALL(address_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_address(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(address_ids) AS a_id) a
    LEFT JOIN
      citydb.address_to_bridge n1
      ON n1.address_id  = a.a_id
    LEFT JOIN
      citydb.address_to_building n2
      ON n2.address_id  = a.a_id
    LEFT JOIN
      citydb.bridge_opening n3
      ON n3.address_id  = a.a_id
    LEFT JOIN
      citydb.opening n4
      ON n4.address_id  = a.a_id
    WHERE n1.address_id IS NULL
      AND n2.address_id IS NULL
      AND n3.address_id IS NULL
      AND n4.address_id IS NULL;
  END IF;

  --delete bridge_constr_elements
  PERFORM
    citydb.del_bridge_constr_element(array_agg(t.id))
  FROM
    citydb.bridge_constr_element t,
    unnest($1) a(a_id)
  WHERE
    t.bridge_id = a.a_id;

  --delete bridge_installations
  PERFORM
    citydb.del_bridge_installation(array_agg(t.id))
  FROM
    citydb.bridge_installation t,
    unnest($1) a(a_id)
  WHERE
    t.bridge_id = a.a_id;

  --delete bridge_rooms
  PERFORM
    citydb.del_bridge_room(array_agg(t.id))
  FROM
    citydb.bridge_room t,
    unnest($1) a(a_id)
  WHERE
    t.bridge_id = a.a_id;

  --delete bridge_thematic_surfaces
  PERFORM
    citydb.del_bridge_thematic_surface(array_agg(t.id))
  FROM
    citydb.bridge_thematic_surface t,
    unnest($1) a(a_id)
  WHERE
    t.bridge_id = a.a_id;

  -- delete ur_bridges
  PERFORM citydb.del_ur_bridge($1, 1);

  -- delete citydb.bridges
  WITH delete_objects AS (
    DELETE FROM
      citydb.bridge t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      lod1_multi_surface_id,
      lod2_multi_surface_id,
      lod3_multi_surface_id,
      lod4_multi_surface_id,
      lod1_solid_id,
      lod2_solid_id,
      lod3_solid_id,
      lod4_solid_id
  )
  SELECT
    array_agg(id),
    array_agg(lod1_multi_surface_id) ||
    array_agg(lod2_multi_surface_id) ||
    array_agg(lod3_multi_surface_id) ||
    array_agg(lod4_multi_surface_id) ||
    array_agg(lod1_solid_id) ||
    array_agg(lod2_solid_id) ||
    array_agg(lod3_solid_id) ||
    array_agg(lod4_solid_id)
  INTO
    deleted_ids,
    surface_geometry_ids
  FROM
    delete_objects;

  -- delete citydb.surface_geometry(s)
  IF -1 = ALL(surface_geometry_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_surface_geometry(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(surface_geometry_ids) AS a_id) a;
  END IF;

  IF $2 <> 1 THEN
    -- delete cityobject
    PERFORM citydb.del_cityobject(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_bridge(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_bridge(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_bridge_constr_element(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  implicit_geometry_ids bigint[] := '{}';
  surface_geometry_ids bigint[] := '{}';
BEGIN
  -- delete citydb.bridge_constr_elements
  WITH delete_objects AS (
    DELETE FROM
      citydb.bridge_constr_element t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      lod1_implicit_rep_id,
      lod2_implicit_rep_id,
      lod3_implicit_rep_id,
      lod4_implicit_rep_id,
      lod1_brep_id,
      lod2_brep_id,
      lod3_brep_id,
      lod4_brep_id
  )
  SELECT
    array_agg(id),
    array_agg(lod1_implicit_rep_id) ||
    array_agg(lod2_implicit_rep_id) ||
    array_agg(lod3_implicit_rep_id) ||
    array_agg(lod4_implicit_rep_id),
    array_agg(lod1_brep_id) ||
    array_agg(lod2_brep_id) ||
    array_agg(lod3_brep_id) ||
    array_agg(lod4_brep_id)
  INTO
    deleted_ids,
    implicit_geometry_ids,
    surface_geometry_ids
  FROM
    delete_objects;

  -- delete citydb.implicit_geometry(s)
  IF -1 = ALL(implicit_geometry_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_implicit_geometry(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(implicit_geometry_ids) AS a_id) a
    LEFT JOIN
      citydb.bridge_constr_element n1
      ON n1.lod1_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_constr_element n2
      ON n2.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_constr_element n3
      ON n3.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_constr_element n4
      ON n4.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_furniture n5
      ON n5.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_installation n6
      ON n6.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_installation n7
      ON n7.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_installation n8
      ON n8.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_opening n9
      ON n9.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_opening n10
      ON n10.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.building_furniture n11
      ON n11.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.building_installation n12
      ON n12.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.building_installation n13
      ON n13.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.building_installation n14
      ON n14.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.city_furniture n15
      ON n15.lod1_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.city_furniture n16
      ON n16.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.city_furniture n17
      ON n17.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.city_furniture n18
      ON n18.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n19
      ON n19.lod0_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n20
      ON n20.lod1_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n21
      ON n21.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n22
      ON n22.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n23
      ON n23.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.opening n24
      ON n24.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.opening n25
      ON n25.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.solitary_vegetat_object n26
      ON n26.lod1_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.solitary_vegetat_object n27
      ON n27.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.solitary_vegetat_object n28
      ON n28.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.solitary_vegetat_object n29
      ON n29.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_furniture n30
      ON n30.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_installation n31
      ON n31.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_installation n32
      ON n32.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_installation n33
      ON n33.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_opening n34
      ON n34.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_opening n35
      ON n35.lod4_implicit_rep_id  = a.a_id
    WHERE n1.lod1_implicit_rep_id IS NULL
      AND n2.lod2_implicit_rep_id IS NULL
      AND n3.lod3_implicit_rep_id IS NULL
      AND n4.lod4_implicit_rep_id IS NULL
      AND n5.lod4_implicit_rep_id IS NULL
      AND n6.lod2_implicit_rep_id IS NULL
      AND n7.lod3_implicit_rep_id IS NULL
      AND n8.lod4_implicit_rep_id IS NULL
      AND n9.lod3_implicit_rep_id IS NULL
      AND n10.lod4_implicit_rep_id IS NULL
      AND n11.lod4_implicit_rep_id IS NULL
      AND n12.lod2_implicit_rep_id IS NULL
      AND n13.lod3_implicit_rep_id IS NULL
      AND n14.lod4_implicit_rep_id IS NULL
      AND n15.lod1_implicit_rep_id IS NULL
      AND n16.lod2_implicit_rep_id IS NULL
      AND n17.lod3_implicit_rep_id IS NULL
      AND n18.lod4_implicit_rep_id IS NULL
      AND n19.lod0_implicit_rep_id IS NULL
      AND n20.lod1_implicit_rep_id IS NULL
      AND n21.lod2_implicit_rep_id IS NULL
      AND n22.lod3_implicit_rep_id IS NULL
      AND n23.lod4_implicit_rep_id IS NULL
      AND n24.lod3_implicit_rep_id IS NULL
      AND n25.lod4_implicit_rep_id IS NULL
      AND n26.lod1_implicit_rep_id IS NULL
      AND n27.lod2_implicit_rep_id IS NULL
      AND n28.lod3_implicit_rep_id IS NULL
      AND n29.lod4_implicit_rep_id IS NULL
      AND n30.lod4_implicit_rep_id IS NULL
      AND n31.lod2_implicit_rep_id IS NULL
      AND n32.lod3_implicit_rep_id IS NULL
      AND n33.lod4_implicit_rep_id IS NULL
      AND n34.lod3_implicit_rep_id IS NULL
      AND n35.lod4_implicit_rep_id IS NULL;
  END IF;

  -- delete citydb.surface_geometry(s)
  IF -1 = ALL(surface_geometry_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_surface_geometry(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(surface_geometry_ids) AS a_id) a;
  END IF;

  IF $2 <> 1 THEN
    -- delete cityobject
    PERFORM citydb.del_cityobject(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_bridge_constr_element(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_bridge_constr_element(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_bridge_furniture(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  implicit_geometry_ids bigint[] := '{}';
  surface_geometry_ids bigint[] := '{}';
BEGIN
  -- delete citydb.bridge_furnitures
  WITH delete_objects AS (
    DELETE FROM
      citydb.bridge_furniture t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      lod4_implicit_rep_id,
      lod4_brep_id
  )
  SELECT
    array_agg(id),
    array_agg(lod4_implicit_rep_id),
    array_agg(lod4_brep_id)
  INTO
    deleted_ids,
    implicit_geometry_ids,
    surface_geometry_ids
  FROM
    delete_objects;

  -- delete citydb.implicit_geometry(s)
  IF -1 = ALL(implicit_geometry_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_implicit_geometry(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(implicit_geometry_ids) AS a_id) a
    LEFT JOIN
      citydb.bridge_constr_element n1
      ON n1.lod1_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_constr_element n2
      ON n2.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_constr_element n3
      ON n3.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_constr_element n4
      ON n4.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_furniture n5
      ON n5.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_installation n6
      ON n6.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_installation n7
      ON n7.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_installation n8
      ON n8.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_opening n9
      ON n9.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_opening n10
      ON n10.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.building_furniture n11
      ON n11.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.building_installation n12
      ON n12.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.building_installation n13
      ON n13.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.building_installation n14
      ON n14.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.city_furniture n15
      ON n15.lod1_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.city_furniture n16
      ON n16.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.city_furniture n17
      ON n17.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.city_furniture n18
      ON n18.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n19
      ON n19.lod0_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n20
      ON n20.lod1_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n21
      ON n21.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n22
      ON n22.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n23
      ON n23.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.opening n24
      ON n24.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.opening n25
      ON n25.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.solitary_vegetat_object n26
      ON n26.lod1_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.solitary_vegetat_object n27
      ON n27.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.solitary_vegetat_object n28
      ON n28.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.solitary_vegetat_object n29
      ON n29.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_furniture n30
      ON n30.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_installation n31
      ON n31.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_installation n32
      ON n32.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_installation n33
      ON n33.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_opening n34
      ON n34.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_opening n35
      ON n35.lod4_implicit_rep_id  = a.a_id
    WHERE n1.lod1_implicit_rep_id IS NULL
      AND n2.lod2_implicit_rep_id IS NULL
      AND n3.lod3_implicit_rep_id IS NULL
      AND n4.lod4_implicit_rep_id IS NULL
      AND n5.lod4_implicit_rep_id IS NULL
      AND n6.lod2_implicit_rep_id IS NULL
      AND n7.lod3_implicit_rep_id IS NULL
      AND n8.lod4_implicit_rep_id IS NULL
      AND n9.lod3_implicit_rep_id IS NULL
      AND n10.lod4_implicit_rep_id IS NULL
      AND n11.lod4_implicit_rep_id IS NULL
      AND n12.lod2_implicit_rep_id IS NULL
      AND n13.lod3_implicit_rep_id IS NULL
      AND n14.lod4_implicit_rep_id IS NULL
      AND n15.lod1_implicit_rep_id IS NULL
      AND n16.lod2_implicit_rep_id IS NULL
      AND n17.lod3_implicit_rep_id IS NULL
      AND n18.lod4_implicit_rep_id IS NULL
      AND n19.lod0_implicit_rep_id IS NULL
      AND n20.lod1_implicit_rep_id IS NULL
      AND n21.lod2_implicit_rep_id IS NULL
      AND n22.lod3_implicit_rep_id IS NULL
      AND n23.lod4_implicit_rep_id IS NULL
      AND n24.lod3_implicit_rep_id IS NULL
      AND n25.lod4_implicit_rep_id IS NULL
      AND n26.lod1_implicit_rep_id IS NULL
      AND n27.lod2_implicit_rep_id IS NULL
      AND n28.lod3_implicit_rep_id IS NULL
      AND n29.lod4_implicit_rep_id IS NULL
      AND n30.lod4_implicit_rep_id IS NULL
      AND n31.lod2_implicit_rep_id IS NULL
      AND n32.lod3_implicit_rep_id IS NULL
      AND n33.lod4_implicit_rep_id IS NULL
      AND n34.lod3_implicit_rep_id IS NULL
      AND n35.lod4_implicit_rep_id IS NULL;
  END IF;

  -- delete citydb.surface_geometry(s)
  IF -1 = ALL(surface_geometry_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_surface_geometry(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(surface_geometry_ids) AS a_id) a;
  END IF;

  IF $2 <> 1 THEN
    -- delete cityobject
    PERFORM citydb.del_cityobject(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_bridge_furniture(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_bridge_furniture(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_bridge_installation(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  implicit_geometry_ids bigint[] := '{}';
  surface_geometry_ids bigint[] := '{}';
BEGIN
  --delete bridge_thematic_surfaces
  PERFORM
    citydb.del_bridge_thematic_surface(array_agg(t.id))
  FROM
    citydb.bridge_thematic_surface t,
    unnest($1) a(a_id)
  WHERE
    t.bridge_installation_id = a.a_id;

  -- delete citydb.bridge_installations
  WITH delete_objects AS (
    DELETE FROM
      citydb.bridge_installation t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      lod2_implicit_rep_id,
      lod3_implicit_rep_id,
      lod4_implicit_rep_id,
      lod2_brep_id,
      lod3_brep_id,
      lod4_brep_id
  )
  SELECT
    array_agg(id),
    array_agg(lod2_implicit_rep_id) ||
    array_agg(lod3_implicit_rep_id) ||
    array_agg(lod4_implicit_rep_id),
    array_agg(lod2_brep_id) ||
    array_agg(lod3_brep_id) ||
    array_agg(lod4_brep_id)
  INTO
    deleted_ids,
    implicit_geometry_ids,
    surface_geometry_ids
  FROM
    delete_objects;

  -- delete citydb.implicit_geometry(s)
  IF -1 = ALL(implicit_geometry_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_implicit_geometry(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(implicit_geometry_ids) AS a_id) a
    LEFT JOIN
      citydb.bridge_constr_element n1
      ON n1.lod1_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_constr_element n2
      ON n2.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_constr_element n3
      ON n3.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_constr_element n4
      ON n4.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_furniture n5
      ON n5.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_installation n6
      ON n6.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_installation n7
      ON n7.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_installation n8
      ON n8.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_opening n9
      ON n9.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_opening n10
      ON n10.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.building_furniture n11
      ON n11.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.building_installation n12
      ON n12.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.building_installation n13
      ON n13.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.building_installation n14
      ON n14.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.city_furniture n15
      ON n15.lod1_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.city_furniture n16
      ON n16.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.city_furniture n17
      ON n17.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.city_furniture n18
      ON n18.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n19
      ON n19.lod0_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n20
      ON n20.lod1_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n21
      ON n21.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n22
      ON n22.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n23
      ON n23.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.opening n24
      ON n24.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.opening n25
      ON n25.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.solitary_vegetat_object n26
      ON n26.lod1_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.solitary_vegetat_object n27
      ON n27.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.solitary_vegetat_object n28
      ON n28.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.solitary_vegetat_object n29
      ON n29.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_furniture n30
      ON n30.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_installation n31
      ON n31.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_installation n32
      ON n32.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_installation n33
      ON n33.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_opening n34
      ON n34.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_opening n35
      ON n35.lod4_implicit_rep_id  = a.a_id
    WHERE n1.lod1_implicit_rep_id IS NULL
      AND n2.lod2_implicit_rep_id IS NULL
      AND n3.lod3_implicit_rep_id IS NULL
      AND n4.lod4_implicit_rep_id IS NULL
      AND n5.lod4_implicit_rep_id IS NULL
      AND n6.lod2_implicit_rep_id IS NULL
      AND n7.lod3_implicit_rep_id IS NULL
      AND n8.lod4_implicit_rep_id IS NULL
      AND n9.lod3_implicit_rep_id IS NULL
      AND n10.lod4_implicit_rep_id IS NULL
      AND n11.lod4_implicit_rep_id IS NULL
      AND n12.lod2_implicit_rep_id IS NULL
      AND n13.lod3_implicit_rep_id IS NULL
      AND n14.lod4_implicit_rep_id IS NULL
      AND n15.lod1_implicit_rep_id IS NULL
      AND n16.lod2_implicit_rep_id IS NULL
      AND n17.lod3_implicit_rep_id IS NULL
      AND n18.lod4_implicit_rep_id IS NULL
      AND n19.lod0_implicit_rep_id IS NULL
      AND n20.lod1_implicit_rep_id IS NULL
      AND n21.lod2_implicit_rep_id IS NULL
      AND n22.lod3_implicit_rep_id IS NULL
      AND n23.lod4_implicit_rep_id IS NULL
      AND n24.lod3_implicit_rep_id IS NULL
      AND n25.lod4_implicit_rep_id IS NULL
      AND n26.lod1_implicit_rep_id IS NULL
      AND n27.lod2_implicit_rep_id IS NULL
      AND n28.lod3_implicit_rep_id IS NULL
      AND n29.lod4_implicit_rep_id IS NULL
      AND n30.lod4_implicit_rep_id IS NULL
      AND n31.lod2_implicit_rep_id IS NULL
      AND n32.lod3_implicit_rep_id IS NULL
      AND n33.lod4_implicit_rep_id IS NULL
      AND n34.lod3_implicit_rep_id IS NULL
      AND n35.lod4_implicit_rep_id IS NULL;
  END IF;

  -- delete citydb.surface_geometry(s)
  IF -1 = ALL(surface_geometry_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_surface_geometry(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(surface_geometry_ids) AS a_id) a;
  END IF;

  IF $2 <> 1 THEN
    -- delete cityobject
    PERFORM citydb.del_cityobject(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_bridge_installation(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_bridge_installation(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_bridge_opening(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  implicit_geometry_ids bigint[] := '{}';
  surface_geometry_ids bigint[] := '{}';
  address_ids bigint[] := '{}';
BEGIN
  -- delete citydb.bridge_openings
  WITH delete_objects AS (
    DELETE FROM
      citydb.bridge_opening t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      lod3_implicit_rep_id,
      lod4_implicit_rep_id,
      lod3_multi_surface_id,
      lod4_multi_surface_id,
      address_id
  )
  SELECT
    array_agg(id),
    array_agg(lod3_implicit_rep_id) ||
    array_agg(lod4_implicit_rep_id),
    array_agg(lod3_multi_surface_id) ||
    array_agg(lod4_multi_surface_id),
    array_agg(address_id)
  INTO
    deleted_ids,
    implicit_geometry_ids,
    surface_geometry_ids,
    address_ids
  FROM
    delete_objects;

  -- delete citydb.implicit_geometry(s)
  IF -1 = ALL(implicit_geometry_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_implicit_geometry(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(implicit_geometry_ids) AS a_id) a
    LEFT JOIN
      citydb.bridge_constr_element n1
      ON n1.lod1_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_constr_element n2
      ON n2.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_constr_element n3
      ON n3.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_constr_element n4
      ON n4.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_furniture n5
      ON n5.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_installation n6
      ON n6.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_installation n7
      ON n7.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_installation n8
      ON n8.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_opening n9
      ON n9.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_opening n10
      ON n10.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.building_furniture n11
      ON n11.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.building_installation n12
      ON n12.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.building_installation n13
      ON n13.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.building_installation n14
      ON n14.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.city_furniture n15
      ON n15.lod1_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.city_furniture n16
      ON n16.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.city_furniture n17
      ON n17.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.city_furniture n18
      ON n18.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n19
      ON n19.lod0_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n20
      ON n20.lod1_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n21
      ON n21.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n22
      ON n22.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n23
      ON n23.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.opening n24
      ON n24.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.opening n25
      ON n25.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.solitary_vegetat_object n26
      ON n26.lod1_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.solitary_vegetat_object n27
      ON n27.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.solitary_vegetat_object n28
      ON n28.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.solitary_vegetat_object n29
      ON n29.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_furniture n30
      ON n30.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_installation n31
      ON n31.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_installation n32
      ON n32.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_installation n33
      ON n33.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_opening n34
      ON n34.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_opening n35
      ON n35.lod4_implicit_rep_id  = a.a_id
    WHERE n1.lod1_implicit_rep_id IS NULL
      AND n2.lod2_implicit_rep_id IS NULL
      AND n3.lod3_implicit_rep_id IS NULL
      AND n4.lod4_implicit_rep_id IS NULL
      AND n5.lod4_implicit_rep_id IS NULL
      AND n6.lod2_implicit_rep_id IS NULL
      AND n7.lod3_implicit_rep_id IS NULL
      AND n8.lod4_implicit_rep_id IS NULL
      AND n9.lod3_implicit_rep_id IS NULL
      AND n10.lod4_implicit_rep_id IS NULL
      AND n11.lod4_implicit_rep_id IS NULL
      AND n12.lod2_implicit_rep_id IS NULL
      AND n13.lod3_implicit_rep_id IS NULL
      AND n14.lod4_implicit_rep_id IS NULL
      AND n15.lod1_implicit_rep_id IS NULL
      AND n16.lod2_implicit_rep_id IS NULL
      AND n17.lod3_implicit_rep_id IS NULL
      AND n18.lod4_implicit_rep_id IS NULL
      AND n19.lod0_implicit_rep_id IS NULL
      AND n20.lod1_implicit_rep_id IS NULL
      AND n21.lod2_implicit_rep_id IS NULL
      AND n22.lod3_implicit_rep_id IS NULL
      AND n23.lod4_implicit_rep_id IS NULL
      AND n24.lod3_implicit_rep_id IS NULL
      AND n25.lod4_implicit_rep_id IS NULL
      AND n26.lod1_implicit_rep_id IS NULL
      AND n27.lod2_implicit_rep_id IS NULL
      AND n28.lod3_implicit_rep_id IS NULL
      AND n29.lod4_implicit_rep_id IS NULL
      AND n30.lod4_implicit_rep_id IS NULL
      AND n31.lod2_implicit_rep_id IS NULL
      AND n32.lod3_implicit_rep_id IS NULL
      AND n33.lod4_implicit_rep_id IS NULL
      AND n34.lod3_implicit_rep_id IS NULL
      AND n35.lod4_implicit_rep_id IS NULL;
  END IF;

  -- delete citydb.surface_geometry(s)
  IF -1 = ALL(surface_geometry_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_surface_geometry(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(surface_geometry_ids) AS a_id) a;
  END IF;

  -- delete citydb.address(s)
  IF -1 = ALL(address_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_address(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(address_ids) AS a_id) a
    LEFT JOIN
      citydb.address_to_bridge n1
      ON n1.address_id  = a.a_id
    LEFT JOIN
      citydb.address_to_building n2
      ON n2.address_id  = a.a_id
    LEFT JOIN
      citydb.bridge_opening n3
      ON n3.address_id  = a.a_id
    LEFT JOIN
      citydb.opening n4
      ON n4.address_id  = a.a_id
    WHERE n1.address_id IS NULL
      AND n2.address_id IS NULL
      AND n3.address_id IS NULL
      AND n4.address_id IS NULL;
  END IF;

  IF $2 <> 1 THEN
    -- delete cityobject
    PERFORM citydb.del_cityobject(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_bridge_opening(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_bridge_opening(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_bridge_room(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  surface_geometry_ids bigint[] := '{}';
BEGIN
  --delete bridge_furnitures
  PERFORM
    citydb.del_bridge_furniture(array_agg(t.id))
  FROM
    citydb.bridge_furniture t,
    unnest($1) a(a_id)
  WHERE
    t.bridge_room_id = a.a_id;

  --delete bridge_installations
  PERFORM
    citydb.del_bridge_installation(array_agg(t.id))
  FROM
    citydb.bridge_installation t,
    unnest($1) a(a_id)
  WHERE
    t.bridge_room_id = a.a_id;

  --delete bridge_thematic_surfaces
  PERFORM
    citydb.del_bridge_thematic_surface(array_agg(t.id))
  FROM
    citydb.bridge_thematic_surface t,
    unnest($1) a(a_id)
  WHERE
    t.bridge_room_id = a.a_id;

  -- delete citydb.bridge_rooms
  WITH delete_objects AS (
    DELETE FROM
      citydb.bridge_room t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      lod4_multi_surface_id,
      lod4_solid_id
  )
  SELECT
    array_agg(id),
    array_agg(lod4_multi_surface_id) ||
    array_agg(lod4_solid_id)
  INTO
    deleted_ids,
    surface_geometry_ids
  FROM
    delete_objects;

  -- delete citydb.surface_geometry(s)
  IF -1 = ALL(surface_geometry_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_surface_geometry(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(surface_geometry_ids) AS a_id) a;
  END IF;

  IF $2 <> 1 THEN
    -- delete cityobject
    PERFORM citydb.del_cityobject(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_bridge_room(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_bridge_room(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_bridge_thematic_surface(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  bridge_opening_ids bigint[] := '{}';
  surface_geometry_ids bigint[] := '{}';
BEGIN
  -- delete references to bridge_openings
  WITH del_bridge_opening_refs AS (
    DELETE FROM
      citydb.bridge_open_to_them_srf t
    USING
      unnest($1) a(a_id)
    WHERE
      t.bridge_thematic_surface_id = a.a_id
    RETURNING
      t.bridge_opening_id
  )
  SELECT
    array_agg(bridge_opening_id)
  INTO
    bridge_opening_ids
  FROM
    del_bridge_opening_refs;

  -- delete citydb.bridge_opening(s)
  IF -1 = ALL(bridge_opening_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_bridge_opening(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(bridge_opening_ids) AS a_id) a;
  END IF;

  -- delete citydb.bridge_thematic_surfaces
  WITH delete_objects AS (
    DELETE FROM
      citydb.bridge_thematic_surface t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      lod2_multi_surface_id,
      lod3_multi_surface_id,
      lod4_multi_surface_id
  )
  SELECT
    array_agg(id),
    array_agg(lod2_multi_surface_id) ||
    array_agg(lod3_multi_surface_id) ||
    array_agg(lod4_multi_surface_id)
  INTO
    deleted_ids,
    surface_geometry_ids
  FROM
    delete_objects;

  -- delete citydb.surface_geometry(s)
  IF -1 = ALL(surface_geometry_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_surface_geometry(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(surface_geometry_ids) AS a_id) a;
  END IF;

  IF $2 <> 1 THEN
    -- delete cityobject
    PERFORM citydb.del_cityobject(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_bridge_thematic_surface(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_bridge_thematic_surface(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_building(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  address_ids bigint[] := '{}';
  surface_geometry_ids bigint[] := '{}';
BEGIN
  -- delete referenced parts
  PERFORM
    citydb.del_building(array_agg(t.id))
  FROM
    citydb.building t,
    unnest($1) a(a_id)
  WHERE
    t.building_parent_id = a.a_id
    AND t.id <> a.a_id;

  -- delete referenced parts
  PERFORM
    citydb.del_building(array_agg(t.id))
  FROM
    citydb.building t,
    unnest($1) a(a_id)
  WHERE
    t.building_root_id = a.a_id
    AND t.id <> a.a_id;

  -- delete references to addresss
  WITH del_address_refs AS (
    DELETE FROM
      citydb.address_to_building t
    USING
      unnest($1) a(a_id)
    WHERE
      t.building_id = a.a_id
    RETURNING
      t.address_id
  )
  SELECT
    array_agg(address_id)
  INTO
    address_ids
  FROM
    del_address_refs;

  -- delete citydb.address(s)
  IF -1 = ALL(address_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_address(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(address_ids) AS a_id) a
    LEFT JOIN
      citydb.address_to_bridge n1
      ON n1.address_id  = a.a_id
    LEFT JOIN
      citydb.address_to_building n2
      ON n2.address_id  = a.a_id
    LEFT JOIN
      citydb.bridge_opening n3
      ON n3.address_id  = a.a_id
    LEFT JOIN
      citydb.opening n4
      ON n4.address_id  = a.a_id
    WHERE n1.address_id IS NULL
      AND n2.address_id IS NULL
      AND n3.address_id IS NULL
      AND n4.address_id IS NULL;
  END IF;

  --delete building_installations
  PERFORM
    citydb.del_building_installation(array_agg(t.id))
  FROM
    citydb.building_installation t,
    unnest($1) a(a_id)
  WHERE
    t.building_id = a.a_id;

  --delete rooms
  PERFORM
    citydb.del_room(array_agg(t.id))
  FROM
    citydb.room t,
    unnest($1) a(a_id)
  WHERE
    t.building_id = a.a_id;

  --delete thematic_surfaces
  PERFORM
    citydb.del_thematic_surface(array_agg(t.id))
  FROM
    citydb.thematic_surface t,
    unnest($1) a(a_id)
  WHERE
    t.building_id = a.a_id;

  -- delete ur_buildings
  PERFORM citydb.del_ur_building($1, 1);

  IF $2 <> 2 THEN
    FOR rec IN
      SELECT
        co.id, co.objectclass_id
      FROM
        citydb.cityobject co, unnest($1) a(a_id)
      WHERE
        co.id = a.a_id
    LOOP
      object_id := rec.id::bigint;
      objectclass_id := rec.objectclass_id::integer;
      CASE
        -- delete ur_undergroundbuilding
        WHEN objectclass_id = 60100 THEN
          dummy_id := citydb.del_ur_undergroundbuilding(array_agg(object_id), 1);
        ELSE
          dummy_id := NULL;
      END CASE;

      IF dummy_id = object_id THEN
        deleted_child_ids := array_append(deleted_child_ids, dummy_id);
      END IF;
    END LOOP;
  END IF;

  -- delete citydb.buildings
  WITH delete_objects AS (
    DELETE FROM
      citydb.building t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      lod0_footprint_id,
      lod0_roofprint_id,
      lod1_multi_surface_id,
      lod2_multi_surface_id,
      lod3_multi_surface_id,
      lod4_multi_surface_id,
      lod1_solid_id,
      lod2_solid_id,
      lod3_solid_id,
      lod4_solid_id
  )
  SELECT
    array_agg(id),
    array_agg(lod0_footprint_id) ||
    array_agg(lod0_roofprint_id) ||
    array_agg(lod1_multi_surface_id) ||
    array_agg(lod2_multi_surface_id) ||
    array_agg(lod3_multi_surface_id) ||
    array_agg(lod4_multi_surface_id) ||
    array_agg(lod1_solid_id) ||
    array_agg(lod2_solid_id) ||
    array_agg(lod3_solid_id) ||
    array_agg(lod4_solid_id)
  INTO
    deleted_ids,
    surface_geometry_ids
  FROM
    delete_objects;

  -- delete citydb.surface_geometry(s)
  IF -1 = ALL(surface_geometry_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_surface_geometry(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(surface_geometry_ids) AS a_id) a;
  END IF;

  IF $2 <> 1 THEN
    -- delete cityobject
    PERFORM citydb.del_cityobject(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_building(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_building(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_building_furniture(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  implicit_geometry_ids bigint[] := '{}';
  surface_geometry_ids bigint[] := '{}';
BEGIN
  -- delete ur_building_furnitures
  PERFORM citydb.del_ur_building_furniture($1, 1);

  -- delete citydb.building_furnitures
  WITH delete_objects AS (
    DELETE FROM
      citydb.building_furniture t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      lod4_implicit_rep_id,
      lod4_brep_id
  )
  SELECT
    array_agg(id),
    array_agg(lod4_implicit_rep_id),
    array_agg(lod4_brep_id)
  INTO
    deleted_ids,
    implicit_geometry_ids,
    surface_geometry_ids
  FROM
    delete_objects;

  -- delete citydb.implicit_geometry(s)
  IF -1 = ALL(implicit_geometry_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_implicit_geometry(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(implicit_geometry_ids) AS a_id) a
    LEFT JOIN
      citydb.bridge_constr_element n1
      ON n1.lod1_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_constr_element n2
      ON n2.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_constr_element n3
      ON n3.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_constr_element n4
      ON n4.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_furniture n5
      ON n5.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_installation n6
      ON n6.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_installation n7
      ON n7.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_installation n8
      ON n8.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_opening n9
      ON n9.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_opening n10
      ON n10.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.building_furniture n11
      ON n11.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.building_installation n12
      ON n12.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.building_installation n13
      ON n13.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.building_installation n14
      ON n14.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.city_furniture n15
      ON n15.lod1_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.city_furniture n16
      ON n16.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.city_furniture n17
      ON n17.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.city_furniture n18
      ON n18.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n19
      ON n19.lod0_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n20
      ON n20.lod1_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n21
      ON n21.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n22
      ON n22.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n23
      ON n23.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.opening n24
      ON n24.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.opening n25
      ON n25.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.solitary_vegetat_object n26
      ON n26.lod1_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.solitary_vegetat_object n27
      ON n27.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.solitary_vegetat_object n28
      ON n28.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.solitary_vegetat_object n29
      ON n29.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_furniture n30
      ON n30.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_installation n31
      ON n31.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_installation n32
      ON n32.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_installation n33
      ON n33.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_opening n34
      ON n34.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_opening n35
      ON n35.lod4_implicit_rep_id  = a.a_id
    WHERE n1.lod1_implicit_rep_id IS NULL
      AND n2.lod2_implicit_rep_id IS NULL
      AND n3.lod3_implicit_rep_id IS NULL
      AND n4.lod4_implicit_rep_id IS NULL
      AND n5.lod4_implicit_rep_id IS NULL
      AND n6.lod2_implicit_rep_id IS NULL
      AND n7.lod3_implicit_rep_id IS NULL
      AND n8.lod4_implicit_rep_id IS NULL
      AND n9.lod3_implicit_rep_id IS NULL
      AND n10.lod4_implicit_rep_id IS NULL
      AND n11.lod4_implicit_rep_id IS NULL
      AND n12.lod2_implicit_rep_id IS NULL
      AND n13.lod3_implicit_rep_id IS NULL
      AND n14.lod4_implicit_rep_id IS NULL
      AND n15.lod1_implicit_rep_id IS NULL
      AND n16.lod2_implicit_rep_id IS NULL
      AND n17.lod3_implicit_rep_id IS NULL
      AND n18.lod4_implicit_rep_id IS NULL
      AND n19.lod0_implicit_rep_id IS NULL
      AND n20.lod1_implicit_rep_id IS NULL
      AND n21.lod2_implicit_rep_id IS NULL
      AND n22.lod3_implicit_rep_id IS NULL
      AND n23.lod4_implicit_rep_id IS NULL
      AND n24.lod3_implicit_rep_id IS NULL
      AND n25.lod4_implicit_rep_id IS NULL
      AND n26.lod1_implicit_rep_id IS NULL
      AND n27.lod2_implicit_rep_id IS NULL
      AND n28.lod3_implicit_rep_id IS NULL
      AND n29.lod4_implicit_rep_id IS NULL
      AND n30.lod4_implicit_rep_id IS NULL
      AND n31.lod2_implicit_rep_id IS NULL
      AND n32.lod3_implicit_rep_id IS NULL
      AND n33.lod4_implicit_rep_id IS NULL
      AND n34.lod3_implicit_rep_id IS NULL
      AND n35.lod4_implicit_rep_id IS NULL;
  END IF;

  -- delete citydb.surface_geometry(s)
  IF -1 = ALL(surface_geometry_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_surface_geometry(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(surface_geometry_ids) AS a_id) a;
  END IF;

  IF $2 <> 1 THEN
    -- delete cityobject
    PERFORM citydb.del_cityobject(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_building_furniture(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_building_furniture(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_building_installation(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  implicit_geometry_ids bigint[] := '{}';
  surface_geometry_ids bigint[] := '{}';
BEGIN
  --delete thematic_surfaces
  PERFORM
    citydb.del_thematic_surface(array_agg(t.id))
  FROM
    citydb.thematic_surface t,
    unnest($1) a(a_id)
  WHERE
    t.building_installation_id = a.a_id;

  -- delete ur_building_installations
  PERFORM citydb.del_ur_building_installation($1, 1);

  -- delete citydb.building_installations
  WITH delete_objects AS (
    DELETE FROM
      citydb.building_installation t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      lod2_implicit_rep_id,
      lod3_implicit_rep_id,
      lod4_implicit_rep_id,
      lod2_brep_id,
      lod3_brep_id,
      lod4_brep_id
  )
  SELECT
    array_agg(id),
    array_agg(lod2_implicit_rep_id) ||
    array_agg(lod3_implicit_rep_id) ||
    array_agg(lod4_implicit_rep_id),
    array_agg(lod2_brep_id) ||
    array_agg(lod3_brep_id) ||
    array_agg(lod4_brep_id)
  INTO
    deleted_ids,
    implicit_geometry_ids,
    surface_geometry_ids
  FROM
    delete_objects;

  -- delete citydb.implicit_geometry(s)
  IF -1 = ALL(implicit_geometry_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_implicit_geometry(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(implicit_geometry_ids) AS a_id) a
    LEFT JOIN
      citydb.bridge_constr_element n1
      ON n1.lod1_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_constr_element n2
      ON n2.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_constr_element n3
      ON n3.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_constr_element n4
      ON n4.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_furniture n5
      ON n5.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_installation n6
      ON n6.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_installation n7
      ON n7.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_installation n8
      ON n8.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_opening n9
      ON n9.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_opening n10
      ON n10.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.building_furniture n11
      ON n11.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.building_installation n12
      ON n12.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.building_installation n13
      ON n13.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.building_installation n14
      ON n14.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.city_furniture n15
      ON n15.lod1_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.city_furniture n16
      ON n16.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.city_furniture n17
      ON n17.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.city_furniture n18
      ON n18.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n19
      ON n19.lod0_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n20
      ON n20.lod1_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n21
      ON n21.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n22
      ON n22.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n23
      ON n23.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.opening n24
      ON n24.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.opening n25
      ON n25.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.solitary_vegetat_object n26
      ON n26.lod1_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.solitary_vegetat_object n27
      ON n27.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.solitary_vegetat_object n28
      ON n28.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.solitary_vegetat_object n29
      ON n29.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_furniture n30
      ON n30.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_installation n31
      ON n31.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_installation n32
      ON n32.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_installation n33
      ON n33.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_opening n34
      ON n34.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_opening n35
      ON n35.lod4_implicit_rep_id  = a.a_id
    WHERE n1.lod1_implicit_rep_id IS NULL
      AND n2.lod2_implicit_rep_id IS NULL
      AND n3.lod3_implicit_rep_id IS NULL
      AND n4.lod4_implicit_rep_id IS NULL
      AND n5.lod4_implicit_rep_id IS NULL
      AND n6.lod2_implicit_rep_id IS NULL
      AND n7.lod3_implicit_rep_id IS NULL
      AND n8.lod4_implicit_rep_id IS NULL
      AND n9.lod3_implicit_rep_id IS NULL
      AND n10.lod4_implicit_rep_id IS NULL
      AND n11.lod4_implicit_rep_id IS NULL
      AND n12.lod2_implicit_rep_id IS NULL
      AND n13.lod3_implicit_rep_id IS NULL
      AND n14.lod4_implicit_rep_id IS NULL
      AND n15.lod1_implicit_rep_id IS NULL
      AND n16.lod2_implicit_rep_id IS NULL
      AND n17.lod3_implicit_rep_id IS NULL
      AND n18.lod4_implicit_rep_id IS NULL
      AND n19.lod0_implicit_rep_id IS NULL
      AND n20.lod1_implicit_rep_id IS NULL
      AND n21.lod2_implicit_rep_id IS NULL
      AND n22.lod3_implicit_rep_id IS NULL
      AND n23.lod4_implicit_rep_id IS NULL
      AND n24.lod3_implicit_rep_id IS NULL
      AND n25.lod4_implicit_rep_id IS NULL
      AND n26.lod1_implicit_rep_id IS NULL
      AND n27.lod2_implicit_rep_id IS NULL
      AND n28.lod3_implicit_rep_id IS NULL
      AND n29.lod4_implicit_rep_id IS NULL
      AND n30.lod4_implicit_rep_id IS NULL
      AND n31.lod2_implicit_rep_id IS NULL
      AND n32.lod3_implicit_rep_id IS NULL
      AND n33.lod4_implicit_rep_id IS NULL
      AND n34.lod3_implicit_rep_id IS NULL
      AND n35.lod4_implicit_rep_id IS NULL;
  END IF;

  -- delete citydb.surface_geometry(s)
  IF -1 = ALL(surface_geometry_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_surface_geometry(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(surface_geometry_ids) AS a_id) a;
  END IF;

  IF $2 <> 1 THEN
    -- delete cityobject
    PERFORM citydb.del_cityobject(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_building_installation(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_building_installation(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_city_furniture(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  implicit_geometry_ids bigint[] := '{}';
  surface_geometry_ids bigint[] := '{}';
BEGIN
  -- delete ur_city_furnitures
  PERFORM citydb.del_ur_city_furniture($1, 1);

  IF $2 <> 2 THEN
    FOR rec IN
      SELECT
        co.id, co.objectclass_id
      FROM
        citydb.cityobject co, unnest($1) a(a_id)
      WHERE
        co.id = a.a_id
    LOOP
      object_id := rec.id::bigint;
      objectclass_id := rec.objectclass_id::integer;
      CASE
        -- delete ur_utilitynetworkelement
        WHEN objectclass_id = 60108 THEN
          dummy_id := citydb.del_ur_utilitynetworkelement(array_agg(object_id), 1);
        -- delete ur_utilitylink
        WHEN objectclass_id = 60111 THEN
          dummy_id := citydb.del_ur_utilitylink(array_agg(object_id), 0);
        -- delete ur_utilitynode
        WHEN objectclass_id = 60113 THEN
          dummy_id := citydb.del_ur_utilitynode(array_agg(object_id), 0);
        -- delete ur_utilitynode
        WHEN objectclass_id = 60114 THEN
          dummy_id := citydb.del_ur_utilitynode(array_agg(object_id), 0);
        -- delete ur_utilitynodecontainer
        WHEN objectclass_id = 60115 THEN
          dummy_id := citydb.del_ur_utilitynodecontainer(array_agg(object_id), 0);
        -- delete ur_utilitynodecontainer
        WHEN objectclass_id = 60116 THEN
          dummy_id := citydb.del_ur_utilitynodecontainer(array_agg(object_id), 0);
        -- delete ur_utilitynodecontainer
        WHEN objectclass_id = 60117 THEN
          dummy_id := citydb.del_ur_utilitynodecontainer(array_agg(object_id), 0);
        -- delete ur_pipe
        WHEN objectclass_id = 60118 THEN
          dummy_id := citydb.del_ur_pipe(array_agg(object_id), 0);
        -- delete ur_sewerpipe
        WHEN objectclass_id = 60119 THEN
          dummy_id := citydb.del_ur_sewerpipe(array_agg(object_id), 0);
        -- delete ur_pipe
        WHEN objectclass_id = 60120 THEN
          dummy_id := citydb.del_ur_pipe(array_agg(object_id), 0);
        -- delete ur_pipe
        WHEN objectclass_id = 60121 THEN
          dummy_id := citydb.del_ur_pipe(array_agg(object_id), 0);
        -- delete ur_pipe
        WHEN objectclass_id = 60122 THEN
          dummy_id := citydb.del_ur_pipe(array_agg(object_id), 0);
        -- delete ur_utilitylink
        WHEN objectclass_id = 60123 THEN
          dummy_id := citydb.del_ur_utilitylink(array_agg(object_id), 0);
        -- delete ur_cable
        WHEN objectclass_id = 60124 THEN
          dummy_id := citydb.del_ur_cable(array_agg(object_id), 0);
        -- delete ur_cable
        WHEN objectclass_id = 60125 THEN
          dummy_id := citydb.del_ur_cable(array_agg(object_id), 0);
        -- delete ur_cable
        WHEN objectclass_id = 60126 THEN
          dummy_id := citydb.del_ur_cable(array_agg(object_id), 0);
        ELSE
          dummy_id := NULL;
      END CASE;

      IF dummy_id = object_id THEN
        deleted_child_ids := array_append(deleted_child_ids, dummy_id);
      END IF;
    END LOOP;
  END IF;

  -- delete citydb.city_furnitures
  WITH delete_objects AS (
    DELETE FROM
      citydb.city_furniture t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      lod1_implicit_rep_id,
      lod2_implicit_rep_id,
      lod3_implicit_rep_id,
      lod4_implicit_rep_id,
      lod1_brep_id,
      lod2_brep_id,
      lod3_brep_id,
      lod4_brep_id
  )
  SELECT
    array_agg(id),
    array_agg(lod1_implicit_rep_id) ||
    array_agg(lod2_implicit_rep_id) ||
    array_agg(lod3_implicit_rep_id) ||
    array_agg(lod4_implicit_rep_id),
    array_agg(lod1_brep_id) ||
    array_agg(lod2_brep_id) ||
    array_agg(lod3_brep_id) ||
    array_agg(lod4_brep_id)
  INTO
    deleted_ids,
    implicit_geometry_ids,
    surface_geometry_ids
  FROM
    delete_objects;

  -- delete citydb.implicit_geometry(s)
  IF -1 = ALL(implicit_geometry_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_implicit_geometry(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(implicit_geometry_ids) AS a_id) a
    LEFT JOIN
      citydb.bridge_constr_element n1
      ON n1.lod1_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_constr_element n2
      ON n2.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_constr_element n3
      ON n3.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_constr_element n4
      ON n4.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_furniture n5
      ON n5.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_installation n6
      ON n6.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_installation n7
      ON n7.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_installation n8
      ON n8.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_opening n9
      ON n9.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_opening n10
      ON n10.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.building_furniture n11
      ON n11.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.building_installation n12
      ON n12.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.building_installation n13
      ON n13.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.building_installation n14
      ON n14.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.city_furniture n15
      ON n15.lod1_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.city_furniture n16
      ON n16.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.city_furniture n17
      ON n17.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.city_furniture n18
      ON n18.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n19
      ON n19.lod0_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n20
      ON n20.lod1_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n21
      ON n21.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n22
      ON n22.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n23
      ON n23.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.opening n24
      ON n24.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.opening n25
      ON n25.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.solitary_vegetat_object n26
      ON n26.lod1_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.solitary_vegetat_object n27
      ON n27.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.solitary_vegetat_object n28
      ON n28.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.solitary_vegetat_object n29
      ON n29.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_furniture n30
      ON n30.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_installation n31
      ON n31.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_installation n32
      ON n32.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_installation n33
      ON n33.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_opening n34
      ON n34.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_opening n35
      ON n35.lod4_implicit_rep_id  = a.a_id
    WHERE n1.lod1_implicit_rep_id IS NULL
      AND n2.lod2_implicit_rep_id IS NULL
      AND n3.lod3_implicit_rep_id IS NULL
      AND n4.lod4_implicit_rep_id IS NULL
      AND n5.lod4_implicit_rep_id IS NULL
      AND n6.lod2_implicit_rep_id IS NULL
      AND n7.lod3_implicit_rep_id IS NULL
      AND n8.lod4_implicit_rep_id IS NULL
      AND n9.lod3_implicit_rep_id IS NULL
      AND n10.lod4_implicit_rep_id IS NULL
      AND n11.lod4_implicit_rep_id IS NULL
      AND n12.lod2_implicit_rep_id IS NULL
      AND n13.lod3_implicit_rep_id IS NULL
      AND n14.lod4_implicit_rep_id IS NULL
      AND n15.lod1_implicit_rep_id IS NULL
      AND n16.lod2_implicit_rep_id IS NULL
      AND n17.lod3_implicit_rep_id IS NULL
      AND n18.lod4_implicit_rep_id IS NULL
      AND n19.lod0_implicit_rep_id IS NULL
      AND n20.lod1_implicit_rep_id IS NULL
      AND n21.lod2_implicit_rep_id IS NULL
      AND n22.lod3_implicit_rep_id IS NULL
      AND n23.lod4_implicit_rep_id IS NULL
      AND n24.lod3_implicit_rep_id IS NULL
      AND n25.lod4_implicit_rep_id IS NULL
      AND n26.lod1_implicit_rep_id IS NULL
      AND n27.lod2_implicit_rep_id IS NULL
      AND n28.lod3_implicit_rep_id IS NULL
      AND n29.lod4_implicit_rep_id IS NULL
      AND n30.lod4_implicit_rep_id IS NULL
      AND n31.lod2_implicit_rep_id IS NULL
      AND n32.lod3_implicit_rep_id IS NULL
      AND n33.lod4_implicit_rep_id IS NULL
      AND n34.lod3_implicit_rep_id IS NULL
      AND n35.lod4_implicit_rep_id IS NULL;
  END IF;

  -- delete citydb.surface_geometry(s)
  IF -1 = ALL(surface_geometry_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_surface_geometry(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(surface_geometry_ids) AS a_id) a;
  END IF;

  IF $2 <> 1 THEN
    -- delete cityobject
    PERFORM citydb.del_cityobject(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_city_furniture(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_city_furniture(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_citymodel(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  cityobject_ids bigint[] := '{}';
BEGIN
  --delete appearances
  PERFORM
    citydb.del_appearance(array_agg(t.id))
  FROM
    citydb.appearance t,
    unnest($1) a(a_id)
  WHERE
    t.citymodel_id = a.a_id;

  -- delete references to cityobjects
  WITH del_cityobject_refs AS (
    DELETE FROM
      citydb.cityobject_member t
    USING
      unnest($1) a(a_id)
    WHERE
      t.citymodel_id = a.a_id
    RETURNING
      t.cityobject_id
  )
  SELECT
    array_agg(cityobject_id)
  INTO
    cityobject_ids
  FROM
    del_cityobject_refs;

  -- delete citydb.cityobject(s)
  IF -1 = ALL(cityobject_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_cityobject(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(cityobject_ids) AS a_id) a
    LEFT JOIN
      citydb.cityobject_member n1
      ON n1.cityobject_id  = a.a_id
    LEFT JOIN
      citydb.group_to_cityobject n2
      ON n2.cityobject_id  = a.a_id
    WHERE n1.cityobject_id IS NULL
      AND n2.cityobject_id IS NULL;
  END IF;

  -- delete citydb.citymodels
  WITH delete_objects AS (
    DELETE FROM
      citydb.citymodel t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_citymodel(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_citymodel(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_cityobject(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  --delete appearances
  PERFORM
    citydb.del_appearance(array_agg(t.id))
  FROM
    citydb.appearance t,
    unnest($1) a(a_id)
  WHERE
    t.cityobject_id = a.a_id;

  --delete cityobject_genericattribs
  PERFORM
    citydb.del_cityobject_genericattrib(array_agg(t.id))
  FROM
    citydb.cityobject_genericattrib t,
    unnest($1) a(a_id)
  WHERE
    t.cityobject_id = a.a_id;

  --delete external_references
  PERFORM
    citydb.del_external_reference(array_agg(t.id))
  FROM
    citydb.external_reference t,
    unnest($1) a(a_id)
  WHERE
    t.cityobject_id = a.a_id;

  -- delete ur_cityobjects
  PERFORM citydb.del_ur_cityobject($1, 1);

  IF $2 <> 2 THEN
    FOR rec IN
      SELECT
        co.id, co.objectclass_id
      FROM
        citydb.cityobject co, unnest($1) a(a_id)
      WHERE
        co.id = a.a_id
    LOOP
      object_id := rec.id::bigint;
      objectclass_id := rec.objectclass_id::integer;
      CASE
        -- delete land_use
        WHEN objectclass_id = 4 THEN
          dummy_id := citydb.del_land_use(array_agg(object_id), 1);
        -- delete generic_cityobject
        WHEN objectclass_id = 5 THEN
          dummy_id := citydb.del_generic_cityobject(array_agg(object_id), 1);
        -- delete solitary_vegetat_object
        WHEN objectclass_id = 7 THEN
          dummy_id := citydb.del_solitary_vegetat_object(array_agg(object_id), 1);
        -- delete plant_cover
        WHEN objectclass_id = 8 THEN
          dummy_id := citydb.del_plant_cover(array_agg(object_id), 1);
        -- delete waterbody
        WHEN objectclass_id = 9 THEN
          dummy_id := citydb.del_waterbody(array_agg(object_id), 1);
        -- delete waterboundary_surface
        WHEN objectclass_id = 10 THEN
          dummy_id := citydb.del_waterboundary_surface(array_agg(object_id), 1);
        -- delete waterboundary_surface
        WHEN objectclass_id = 11 THEN
          dummy_id := citydb.del_waterboundary_surface(array_agg(object_id), 1);
        -- delete waterboundary_surface
        WHEN objectclass_id = 12 THEN
          dummy_id := citydb.del_waterboundary_surface(array_agg(object_id), 1);
        -- delete waterboundary_surface
        WHEN objectclass_id = 13 THEN
          dummy_id := citydb.del_waterboundary_surface(array_agg(object_id), 1);
        -- delete relief_feature
        WHEN objectclass_id = 14 THEN
          dummy_id := citydb.del_relief_feature(array_agg(object_id), 1);
        -- delete relief_component
        WHEN objectclass_id = 15 THEN
          dummy_id := citydb.del_relief_component(array_agg(object_id), 1);
        -- delete tin_relief
        WHEN objectclass_id = 16 THEN
          dummy_id := citydb.del_tin_relief(array_agg(object_id), 0);
        -- delete masspoint_relief
        WHEN objectclass_id = 17 THEN
          dummy_id := citydb.del_masspoint_relief(array_agg(object_id), 0);
        -- delete breakline_relief
        WHEN objectclass_id = 18 THEN
          dummy_id := citydb.del_breakline_relief(array_agg(object_id), 0);
        -- delete raster_relief
        WHEN objectclass_id = 19 THEN
          dummy_id := citydb.del_raster_relief(array_agg(object_id), 0);
        -- delete city_furniture
        WHEN objectclass_id = 21 THEN
          dummy_id := citydb.del_city_furniture(array_agg(object_id), 1);
        -- delete cityobjectgroup
        WHEN objectclass_id = 23 THEN
          dummy_id := citydb.del_cityobjectgroup(array_agg(object_id), 1);
        -- delete building
        WHEN objectclass_id = 24 THEN
          dummy_id := citydb.del_building(array_agg(object_id), 1);
        -- delete building
        WHEN objectclass_id = 25 THEN
          dummy_id := citydb.del_building(array_agg(object_id), 1);
        -- delete building
        WHEN objectclass_id = 26 THEN
          dummy_id := citydb.del_building(array_agg(object_id), 1);
        -- delete building_installation
        WHEN objectclass_id = 27 THEN
          dummy_id := citydb.del_building_installation(array_agg(object_id), 1);
        -- delete building_installation
        WHEN objectclass_id = 28 THEN
          dummy_id := citydb.del_building_installation(array_agg(object_id), 1);
        -- delete thematic_surface
        WHEN objectclass_id = 29 THEN
          dummy_id := citydb.del_thematic_surface(array_agg(object_id), 1);
        -- delete thematic_surface
        WHEN objectclass_id = 30 THEN
          dummy_id := citydb.del_thematic_surface(array_agg(object_id), 1);
        -- delete thematic_surface
        WHEN objectclass_id = 31 THEN
          dummy_id := citydb.del_thematic_surface(array_agg(object_id), 1);
        -- delete thematic_surface
        WHEN objectclass_id = 32 THEN
          dummy_id := citydb.del_thematic_surface(array_agg(object_id), 1);
        -- delete thematic_surface
        WHEN objectclass_id = 33 THEN
          dummy_id := citydb.del_thematic_surface(array_agg(object_id), 1);
        -- delete thematic_surface
        WHEN objectclass_id = 34 THEN
          dummy_id := citydb.del_thematic_surface(array_agg(object_id), 1);
        -- delete thematic_surface
        WHEN objectclass_id = 35 THEN
          dummy_id := citydb.del_thematic_surface(array_agg(object_id), 1);
        -- delete thematic_surface
        WHEN objectclass_id = 36 THEN
          dummy_id := citydb.del_thematic_surface(array_agg(object_id), 1);
        -- delete opening
        WHEN objectclass_id = 37 THEN
          dummy_id := citydb.del_opening(array_agg(object_id), 1);
        -- delete opening
        WHEN objectclass_id = 38 THEN
          dummy_id := citydb.del_opening(array_agg(object_id), 1);
        -- delete opening
        WHEN objectclass_id = 39 THEN
          dummy_id := citydb.del_opening(array_agg(object_id), 1);
        -- delete building_furniture
        WHEN objectclass_id = 40 THEN
          dummy_id := citydb.del_building_furniture(array_agg(object_id), 1);
        -- delete room
        WHEN objectclass_id = 41 THEN
          dummy_id := citydb.del_room(array_agg(object_id), 1);
        -- delete transportation_complex
        WHEN objectclass_id = 42 THEN
          dummy_id := citydb.del_transportation_complex(array_agg(object_id), 1);
        -- delete transportation_complex
        WHEN objectclass_id = 43 THEN
          dummy_id := citydb.del_transportation_complex(array_agg(object_id), 1);
        -- delete transportation_complex
        WHEN objectclass_id = 44 THEN
          dummy_id := citydb.del_transportation_complex(array_agg(object_id), 1);
        -- delete transportation_complex
        WHEN objectclass_id = 45 THEN
          dummy_id := citydb.del_transportation_complex(array_agg(object_id), 1);
        -- delete transportation_complex
        WHEN objectclass_id = 46 THEN
          dummy_id := citydb.del_transportation_complex(array_agg(object_id), 1);
        -- delete traffic_area
        WHEN objectclass_id = 47 THEN
          dummy_id := citydb.del_traffic_area(array_agg(object_id), 1);
        -- delete traffic_area
        WHEN objectclass_id = 48 THEN
          dummy_id := citydb.del_traffic_area(array_agg(object_id), 1);
        -- delete appearance
        WHEN objectclass_id = 50 THEN
          dummy_id := citydb.del_appearance(array_agg(object_id), 0);
        -- delete surface_data
        WHEN objectclass_id = 51 THEN
          dummy_id := citydb.del_surface_data(array_agg(object_id), 0);
        -- delete surface_data
        WHEN objectclass_id = 52 THEN
          dummy_id := citydb.del_surface_data(array_agg(object_id), 0);
        -- delete surface_data
        WHEN objectclass_id = 53 THEN
          dummy_id := citydb.del_surface_data(array_agg(object_id), 0);
        -- delete surface_data
        WHEN objectclass_id = 54 THEN
          dummy_id := citydb.del_surface_data(array_agg(object_id), 0);
        -- delete surface_data
        WHEN objectclass_id = 55 THEN
          dummy_id := citydb.del_surface_data(array_agg(object_id), 0);
        -- delete citymodel
        WHEN objectclass_id = 57 THEN
          dummy_id := citydb.del_citymodel(array_agg(object_id), 0);
        -- delete address
        WHEN objectclass_id = 58 THEN
          dummy_id := citydb.del_address(array_agg(object_id), 0);
        -- delete implicit_geometry
        WHEN objectclass_id = 59 THEN
          dummy_id := citydb.del_implicit_geometry(array_agg(object_id), 0);
        -- delete thematic_surface
        WHEN objectclass_id = 60 THEN
          dummy_id := citydb.del_thematic_surface(array_agg(object_id), 1);
        -- delete thematic_surface
        WHEN objectclass_id = 61 THEN
          dummy_id := citydb.del_thematic_surface(array_agg(object_id), 1);
        -- delete bridge
        WHEN objectclass_id = 62 THEN
          dummy_id := citydb.del_bridge(array_agg(object_id), 1);
        -- delete bridge
        WHEN objectclass_id = 63 THEN
          dummy_id := citydb.del_bridge(array_agg(object_id), 1);
        -- delete bridge
        WHEN objectclass_id = 64 THEN
          dummy_id := citydb.del_bridge(array_agg(object_id), 1);
        -- delete bridge_installation
        WHEN objectclass_id = 65 THEN
          dummy_id := citydb.del_bridge_installation(array_agg(object_id), 1);
        -- delete bridge_installation
        WHEN objectclass_id = 66 THEN
          dummy_id := citydb.del_bridge_installation(array_agg(object_id), 1);
        -- delete bridge_thematic_surface
        WHEN objectclass_id = 67 THEN
          dummy_id := citydb.del_bridge_thematic_surface(array_agg(object_id), 1);
        -- delete bridge_thematic_surface
        WHEN objectclass_id = 68 THEN
          dummy_id := citydb.del_bridge_thematic_surface(array_agg(object_id), 1);
        -- delete bridge_thematic_surface
        WHEN objectclass_id = 69 THEN
          dummy_id := citydb.del_bridge_thematic_surface(array_agg(object_id), 1);
        -- delete bridge_thematic_surface
        WHEN objectclass_id = 70 THEN
          dummy_id := citydb.del_bridge_thematic_surface(array_agg(object_id), 1);
        -- delete bridge_thematic_surface
        WHEN objectclass_id = 71 THEN
          dummy_id := citydb.del_bridge_thematic_surface(array_agg(object_id), 1);
        -- delete bridge_thematic_surface
        WHEN objectclass_id = 72 THEN
          dummy_id := citydb.del_bridge_thematic_surface(array_agg(object_id), 1);
        -- delete bridge_thematic_surface
        WHEN objectclass_id = 73 THEN
          dummy_id := citydb.del_bridge_thematic_surface(array_agg(object_id), 1);
        -- delete bridge_thematic_surface
        WHEN objectclass_id = 74 THEN
          dummy_id := citydb.del_bridge_thematic_surface(array_agg(object_id), 1);
        -- delete bridge_thematic_surface
        WHEN objectclass_id = 75 THEN
          dummy_id := citydb.del_bridge_thematic_surface(array_agg(object_id), 1);
        -- delete bridge_thematic_surface
        WHEN objectclass_id = 76 THEN
          dummy_id := citydb.del_bridge_thematic_surface(array_agg(object_id), 1);
        -- delete bridge_opening
        WHEN objectclass_id = 77 THEN
          dummy_id := citydb.del_bridge_opening(array_agg(object_id), 1);
        -- delete bridge_opening
        WHEN objectclass_id = 78 THEN
          dummy_id := citydb.del_bridge_opening(array_agg(object_id), 1);
        -- delete bridge_opening
        WHEN objectclass_id = 79 THEN
          dummy_id := citydb.del_bridge_opening(array_agg(object_id), 1);
        -- delete bridge_furniture
        WHEN objectclass_id = 80 THEN
          dummy_id := citydb.del_bridge_furniture(array_agg(object_id), 1);
        -- delete bridge_room
        WHEN objectclass_id = 81 THEN
          dummy_id := citydb.del_bridge_room(array_agg(object_id), 1);
        -- delete bridge_constr_element
        WHEN objectclass_id = 82 THEN
          dummy_id := citydb.del_bridge_constr_element(array_agg(object_id), 1);
        -- delete tunnel
        WHEN objectclass_id = 83 THEN
          dummy_id := citydb.del_tunnel(array_agg(object_id), 1);
        -- delete tunnel
        WHEN objectclass_id = 84 THEN
          dummy_id := citydb.del_tunnel(array_agg(object_id), 1);
        -- delete tunnel
        WHEN objectclass_id = 85 THEN
          dummy_id := citydb.del_tunnel(array_agg(object_id), 1);
        -- delete tunnel_installation
        WHEN objectclass_id = 86 THEN
          dummy_id := citydb.del_tunnel_installation(array_agg(object_id), 1);
        -- delete tunnel_installation
        WHEN objectclass_id = 87 THEN
          dummy_id := citydb.del_tunnel_installation(array_agg(object_id), 1);
        -- delete tunnel_thematic_surface
        WHEN objectclass_id = 88 THEN
          dummy_id := citydb.del_tunnel_thematic_surface(array_agg(object_id), 1);
        -- delete tunnel_thematic_surface
        WHEN objectclass_id = 89 THEN
          dummy_id := citydb.del_tunnel_thematic_surface(array_agg(object_id), 1);
        -- delete tunnel_thematic_surface
        WHEN objectclass_id = 90 THEN
          dummy_id := citydb.del_tunnel_thematic_surface(array_agg(object_id), 1);
        -- delete tunnel_thematic_surface
        WHEN objectclass_id = 91 THEN
          dummy_id := citydb.del_tunnel_thematic_surface(array_agg(object_id), 1);
        -- delete tunnel_thematic_surface
        WHEN objectclass_id = 92 THEN
          dummy_id := citydb.del_tunnel_thematic_surface(array_agg(object_id), 1);
        -- delete tunnel_thematic_surface
        WHEN objectclass_id = 93 THEN
          dummy_id := citydb.del_tunnel_thematic_surface(array_agg(object_id), 1);
        -- delete tunnel_thematic_surface
        WHEN objectclass_id = 94 THEN
          dummy_id := citydb.del_tunnel_thematic_surface(array_agg(object_id), 1);
        -- delete tunnel_thematic_surface
        WHEN objectclass_id = 95 THEN
          dummy_id := citydb.del_tunnel_thematic_surface(array_agg(object_id), 1);
        -- delete tunnel_thematic_surface
        WHEN objectclass_id = 96 THEN
          dummy_id := citydb.del_tunnel_thematic_surface(array_agg(object_id), 1);
        -- delete tunnel_thematic_surface
        WHEN objectclass_id = 97 THEN
          dummy_id := citydb.del_tunnel_thematic_surface(array_agg(object_id), 1);
        -- delete tunnel_opening
        WHEN objectclass_id = 98 THEN
          dummy_id := citydb.del_tunnel_opening(array_agg(object_id), 1);
        -- delete tunnel_opening
        WHEN objectclass_id = 99 THEN
          dummy_id := citydb.del_tunnel_opening(array_agg(object_id), 1);
        -- delete tunnel_opening
        WHEN objectclass_id = 100 THEN
          dummy_id := citydb.del_tunnel_opening(array_agg(object_id), 1);
        -- delete tunnel_furniture
        WHEN objectclass_id = 101 THEN
          dummy_id := citydb.del_tunnel_furniture(array_agg(object_id), 1);
        -- delete tunnel_hollow_space
        WHEN objectclass_id = 102 THEN
          dummy_id := citydb.del_tunnel_hollow_space(array_agg(object_id), 1);
        -- delete ur_statisticalgrid
        WHEN objectclass_id = 60000 THEN
          dummy_id := citydb.del_ur_statisticalgrid(array_agg(object_id), 1);
        -- delete ur_population
        WHEN objectclass_id = 60001 THEN
          dummy_id := citydb.del_ur_population(array_agg(object_id), 0);
        -- delete ur_statisticalgrid
        WHEN objectclass_id = 60003 THEN
          dummy_id := citydb.del_ur_statisticalgrid(array_agg(object_id), 1);
        -- delete ur_landprice
        WHEN objectclass_id = 60004 THEN
          dummy_id := citydb.del_ur_landprice(array_agg(object_id), 0);
        -- delete ur_landusediversion
        WHEN objectclass_id = 60006 THEN
          dummy_id := citydb.del_ur_landusediversion(array_agg(object_id), 0);
        -- delete ur_households
        WHEN objectclass_id = 60009 THEN
          dummy_id := citydb.del_ur_households(array_agg(object_id), 0);
        -- delete ur_officesandemployees
        WHEN objectclass_id = 60011 THEN
          dummy_id := citydb.del_ur_officesandemployees(array_agg(object_id), 0);
        -- delete ur_statisticalgrid
        WHEN objectclass_id = 60012 THEN
          dummy_id := citydb.del_ur_statisticalgrid(array_agg(object_id), 1);
        -- delete ur_waterway
        WHEN objectclass_id = 60084 THEN
          dummy_id := citydb.del_ur_waterway(array_agg(object_id), 0);
        -- delete ur_construction
        WHEN objectclass_id = 60086 THEN
          dummy_id := citydb.del_ur_construction(array_agg(object_id), 1);
        -- delete ur_boundarysurface
        WHEN objectclass_id = 60091 THEN
          dummy_id := citydb.del_ur_boundarysurface(array_agg(object_id), 1);
        -- delete ur_constructioninstallati
        WHEN objectclass_id = 60092 THEN
          dummy_id := citydb.del_ur_constructioninstallati(array_agg(object_id), 1);
        -- delete ur_otherconstruction
        WHEN objectclass_id = 60093 THEN
          dummy_id := citydb.del_ur_otherconstruction(array_agg(object_id), 0);
        -- delete ur_boundarysurface
        WHEN objectclass_id = 60094 THEN
          dummy_id := citydb.del_ur_boundarysurface(array_agg(object_id), 1);
        -- delete ur_boundarysurface
        WHEN objectclass_id = 60095 THEN
          dummy_id := citydb.del_ur_boundarysurface(array_agg(object_id), 1);
        -- delete ur_boundarysurface
        WHEN objectclass_id = 60096 THEN
          dummy_id := citydb.del_ur_boundarysurface(array_agg(object_id), 1);
        -- delete ur_boundarysurface
        WHEN objectclass_id = 60097 THEN
          dummy_id := citydb.del_ur_boundarysurface(array_agg(object_id), 1);
        -- delete ur_boundarysurface
        WHEN objectclass_id = 60098 THEN
          dummy_id := citydb.del_ur_boundarysurface(array_agg(object_id), 1);
        -- delete ur_boundarysurface
        WHEN objectclass_id = 60099 THEN
          dummy_id := citydb.del_ur_boundarysurface(array_agg(object_id), 1);
        -- delete ur_undergroundbuilding
        WHEN objectclass_id = 60100 THEN
          dummy_id := citydb.del_ur_undergroundbuilding(array_agg(object_id), 0);
        -- delete ur_utilitynetworkelement
        WHEN objectclass_id = 60108 THEN
          dummy_id := citydb.del_ur_utilitynetworkelement(array_agg(object_id), 0);
        -- delete ur_utilitylink
        WHEN objectclass_id = 60111 THEN
          dummy_id := citydb.del_ur_utilitylink(array_agg(object_id), 0);
        -- delete ur_utilitynode
        WHEN objectclass_id = 60113 THEN
          dummy_id := citydb.del_ur_utilitynode(array_agg(object_id), 0);
        -- delete ur_utilitynode
        WHEN objectclass_id = 60114 THEN
          dummy_id := citydb.del_ur_utilitynode(array_agg(object_id), 0);
        -- delete ur_utilitynodecontainer
        WHEN objectclass_id = 60115 THEN
          dummy_id := citydb.del_ur_utilitynodecontainer(array_agg(object_id), 0);
        -- delete ur_utilitynodecontainer
        WHEN objectclass_id = 60116 THEN
          dummy_id := citydb.del_ur_utilitynodecontainer(array_agg(object_id), 0);
        -- delete ur_utilitynodecontainer
        WHEN objectclass_id = 60117 THEN
          dummy_id := citydb.del_ur_utilitynodecontainer(array_agg(object_id), 0);
        -- delete ur_pipe
        WHEN objectclass_id = 60118 THEN
          dummy_id := citydb.del_ur_pipe(array_agg(object_id), 0);
        -- delete ur_sewerpipe
        WHEN objectclass_id = 60119 THEN
          dummy_id := citydb.del_ur_sewerpipe(array_agg(object_id), 0);
        -- delete ur_pipe
        WHEN objectclass_id = 60120 THEN
          dummy_id := citydb.del_ur_pipe(array_agg(object_id), 0);
        -- delete ur_pipe
        WHEN objectclass_id = 60121 THEN
          dummy_id := citydb.del_ur_pipe(array_agg(object_id), 0);
        -- delete ur_pipe
        WHEN objectclass_id = 60122 THEN
          dummy_id := citydb.del_ur_pipe(array_agg(object_id), 0);
        -- delete ur_utilitylink
        WHEN objectclass_id = 60123 THEN
          dummy_id := citydb.del_ur_utilitylink(array_agg(object_id), 0);
        -- delete ur_cable
        WHEN objectclass_id = 60124 THEN
          dummy_id := citydb.del_ur_cable(array_agg(object_id), 0);
        -- delete ur_cable
        WHEN objectclass_id = 60125 THEN
          dummy_id := citydb.del_ur_cable(array_agg(object_id), 0);
        -- delete ur_cable
        WHEN objectclass_id = 60126 THEN
          dummy_id := citydb.del_ur_cable(array_agg(object_id), 0);
        -- delete ur_publicland
        WHEN objectclass_id = 60179 THEN
          dummy_id := citydb.del_ur_publicland(array_agg(object_id), 0);
        -- delete ur_publictransit
        WHEN objectclass_id = 60207 THEN
          dummy_id := citydb.del_ur_publictransit(array_agg(object_id), 1);
        -- delete ur_route
        WHEN objectclass_id = 60208 THEN
          dummy_id := citydb.del_ur_route(array_agg(object_id), 0);
        -- delete ur_agency
        WHEN objectclass_id = 60210 THEN
          dummy_id := citydb.del_ur_agency(array_agg(object_id), 0);
        -- delete ur_stop
        WHEN objectclass_id = 60211 THEN
          dummy_id := citydb.del_ur_stop(array_agg(object_id), 0);
        -- delete ur_publictransit
        WHEN objectclass_id = 60212 THEN
          dummy_id := citydb.del_ur_publictransit(array_agg(object_id), 1);
        -- delete ur_trip
        WHEN objectclass_id = 60213 THEN
          dummy_id := citydb.del_ur_trip(array_agg(object_id), 0);
        -- delete ur_calendar
        WHEN objectclass_id = 60214 THEN
          dummy_id := citydb.del_ur_calendar(array_agg(object_id), 0);
        -- delete ur_calendardate
        WHEN objectclass_id = 60215 THEN
          dummy_id := citydb.del_ur_calendardate(array_agg(object_id), 0);
        -- delete ur_office
        WHEN objectclass_id = 60216 THEN
          dummy_id := citydb.del_ur_office(array_agg(object_id), 0);
        -- delete ur_publictransit
        WHEN objectclass_id = 60217 THEN
          dummy_id := citydb.del_ur_publictransit(array_agg(object_id), 1);
        -- delete ur_fareattribute
        WHEN objectclass_id = 60219 THEN
          dummy_id := citydb.del_ur_fareattribute(array_agg(object_id), 0);
        -- delete ur_pathway
        WHEN objectclass_id = 60220 THEN
          dummy_id := citydb.del_ur_pathway(array_agg(object_id), 0);
        -- delete ur_translationjp
        WHEN objectclass_id = 60221 THEN
          dummy_id := citydb.del_ur_translationjp(array_agg(object_id), 0);
        -- delete ur_attribution
        WHEN objectclass_id = 60222 THEN
          dummy_id := citydb.del_ur_attribution(array_agg(object_id), 0);
        -- delete ur_urbanfunction
        WHEN objectclass_id = 60231 THEN
          dummy_id := citydb.del_ur_urbanfunction(array_agg(object_id), 1);
        -- delete ur_zone
        WHEN objectclass_id = 60259 THEN
          dummy_id := citydb.del_ur_zone(array_agg(object_id), 0);
        -- delete ur_threedimensionalextent
        WHEN objectclass_id = 60260 THEN
          dummy_id := citydb.del_ur_threedimensionalextent(array_agg(object_id), 0);
        -- delete ur_administration
        WHEN objectclass_id = 60261 THEN
          dummy_id := citydb.del_ur_administration(array_agg(object_id), 0);
        -- delete ur_disasterdamage
        WHEN objectclass_id = 60262 THEN
          dummy_id := citydb.del_ur_disasterdamage(array_agg(object_id), 0);
        -- delete ur_pollution
        WHEN objectclass_id = 60263 THEN
          dummy_id := citydb.del_ur_pollution(array_agg(object_id), 0);
        -- delete ur_disasterpreventionbase
        WHEN objectclass_id = 60264 THEN
          dummy_id := citydb.del_ur_disasterpreventionbase(array_agg(object_id), 0);
        -- delete ur_recreations
        WHEN objectclass_id = 60265 THEN
          dummy_id := citydb.del_ur_recreations(array_agg(object_id), 0);
        -- delete ur_urbanfunction
        WHEN objectclass_id = 60266 THEN
          dummy_id := citydb.del_ur_urbanfunction(array_agg(object_id), 1);
        -- delete ur_landusediversion_2
        WHEN objectclass_id = 60267 THEN
          dummy_id := citydb.del_ur_landusediversion_2(array_agg(object_id), 0);
        -- delete ur_urbanization
        WHEN objectclass_id = 60268 THEN
          dummy_id := citydb.del_ur_urbanization(array_agg(object_id), 0);
        -- delete ur_did
        WHEN objectclass_id = 60271 THEN
          dummy_id := citydb.del_ur_did(array_agg(object_id), 0);
        -- delete ur_censusblock
        WHEN objectclass_id = 60272 THEN
          dummy_id := citydb.del_ur_censusblock(array_agg(object_id), 0);
        -- delete ur_developmentproject
        WHEN objectclass_id = 60273 THEN
          dummy_id := citydb.del_ur_developmentproject(array_agg(object_id), 0);
        -- delete ur_newhousing
        WHEN objectclass_id = 60274 THEN
          dummy_id := citydb.del_ur_newhousing(array_agg(object_id), 0);
        -- delete ur_urbanfacilitystatus
        WHEN objectclass_id = 60275 THEN
          dummy_id := citydb.del_ur_urbanfacilitystatus(array_agg(object_id), 0);
        -- delete ur_publictransitfacility
        WHEN objectclass_id = 60276 THEN
          dummy_id := citydb.del_ur_publictransitfacility(array_agg(object_id), 0);
        -- delete ur_landprice_2
        WHEN objectclass_id = 60277 THEN
          dummy_id := citydb.del_ur_landprice_2(array_agg(object_id), 0);
        -- delete ur_urbanfunction
        WHEN objectclass_id = 60278 THEN
          dummy_id := citydb.del_ur_urbanfunction(array_agg(object_id), 1);
        -- delete ur_weatherobservation
        WHEN objectclass_id = 60279 THEN
          dummy_id := citydb.del_ur_weatherobservation(array_agg(object_id), 0);
        -- delete ur_urbanfunction
        WHEN objectclass_id = 60280 THEN
          dummy_id := citydb.del_ur_urbanfunction(array_agg(object_id), 1);
        -- delete ur_urbanfunction
        WHEN objectclass_id = 60281 THEN
          dummy_id := citydb.del_ur_urbanfunction(array_agg(object_id), 1);
        -- delete ur_scenicresource
        WHEN objectclass_id = 60282 THEN
          dummy_id := citydb.del_ur_scenicresource(array_agg(object_id), 0);
        -- delete ur_urbanplanningarea
        WHEN objectclass_id = 60283 THEN
          dummy_id := citydb.del_ur_urbanplanningarea(array_agg(object_id), 0);
        -- delete ur_quasiurbanplanningarea
        WHEN objectclass_id = 60284 THEN
          dummy_id := citydb.del_ur_quasiurbanplanningarea(array_agg(object_id), 0);
        -- delete ur_areaclassification
        WHEN objectclass_id = 60285 THEN
          dummy_id := citydb.del_ur_areaclassification(array_agg(object_id), 0);
        -- delete ur_districtsandzones
        WHEN objectclass_id = 60286 THEN
          dummy_id := citydb.del_ur_districtsandzones(array_agg(object_id), 0);
        -- delete ur_projectpromotionarea
        WHEN objectclass_id = 60287 THEN
          dummy_id := citydb.del_ur_projectpromotionarea(array_agg(object_id), 0);
        -- delete ur_zone
        WHEN objectclass_id = 60288 THEN
          dummy_id := citydb.del_ur_zone(array_agg(object_id), 0);
        -- delete ur_urbandisasterrecoveryp
        WHEN objectclass_id = 60289 THEN
          dummy_id := citydb.del_ur_urbandisasterrecoveryp(array_agg(object_id), 0);
        -- delete ur_urbandevelopmentproj_2
        WHEN objectclass_id = 60290 THEN
          dummy_id := citydb.del_ur_urbandevelopmentproj_2(array_agg(object_id), 0);
        -- delete ur_scheduledareaforurband
        WHEN objectclass_id = 60291 THEN
          dummy_id := citydb.del_ur_scheduledareaforurband(array_agg(object_id), 0);
        -- delete ur_urbanfacility
        WHEN objectclass_id = 60292 THEN
          dummy_id := citydb.del_ur_urbanfacility(array_agg(object_id), 0);
        -- delete ur_abstractdistrictplan
        WHEN objectclass_id = 60293 THEN
          dummy_id := citydb.del_ur_abstractdistrictplan(array_agg(object_id), 0);
        -- delete ur_districtdevelopmentpla
        WHEN objectclass_id = 60294 THEN
          dummy_id := citydb.del_ur_districtdevelopmentpla(array_agg(object_id), 0);
        -- delete ur_district
        WHEN objectclass_id = 60295 THEN
          dummy_id := citydb.del_ur_district(array_agg(object_id), 0);
        -- delete ur_zone
        WHEN objectclass_id = 60296 THEN
          dummy_id := citydb.del_ur_zone(array_agg(object_id), 0);
        -- delete ur_zonaldisasterpreventio
        WHEN objectclass_id = 60297 THEN
          dummy_id := citydb.del_ur_zonaldisasterpreventio(array_agg(object_id), 0);
        -- delete ur_zone
        WHEN objectclass_id = 60298 THEN
          dummy_id := citydb.del_ur_zone(array_agg(object_id), 0);
        -- delete ur_urgenturbanrenewalarea
        WHEN objectclass_id = 60299 THEN
          dummy_id := citydb.del_ur_urgenturbanrenewalarea(array_agg(object_id), 0);
        -- delete ur_privateurbanrenewalpro
        WHEN objectclass_id = 60300 THEN
          dummy_id := citydb.del_ur_privateurbanrenewalpro(array_agg(object_id), 0);
        -- delete ur_globalhubcitydevelopme
        WHEN objectclass_id = 60301 THEN
          dummy_id := citydb.del_ur_globalhubcitydevelopme(array_agg(object_id), 0);
        -- delete ur_agreement
        WHEN objectclass_id = 60302 THEN
          dummy_id := citydb.del_ur_agreement(array_agg(object_id), 0);
        -- delete ur_zone
        WHEN objectclass_id = 60303 THEN
          dummy_id := citydb.del_ur_zone(array_agg(object_id), 0);
        -- delete ur_sedimentdisasterpronea
        WHEN objectclass_id = 60304 THEN
          dummy_id := citydb.del_ur_sedimentdisasterpronea(array_agg(object_id), 0);
        -- delete ur_zone
        WHEN objectclass_id = 60305 THEN
          dummy_id := citydb.del_ur_zone(array_agg(object_id), 0);
        -- delete ur_zone
        WHEN objectclass_id = 60306 THEN
          dummy_id := citydb.del_ur_zone(array_agg(object_id), 0);
        -- delete ur_zone
        WHEN objectclass_id = 60307 THEN
          dummy_id := citydb.del_ur_zone(array_agg(object_id), 0);
        -- delete ur_zone
        WHEN objectclass_id = 60308 THEN
          dummy_id := citydb.del_ur_zone(array_agg(object_id), 0);
        -- delete ur_usedistrict
        WHEN objectclass_id = 60309 THEN
          dummy_id := citydb.del_ur_usedistrict(array_agg(object_id), 0);
        -- delete ur_specialusedistrict
        WHEN objectclass_id = 60310 THEN
          dummy_id := citydb.del_ur_specialusedistrict(array_agg(object_id), 0);
        -- delete ur_specialuserestrictiond
        WHEN objectclass_id = 60311 THEN
          dummy_id := citydb.del_ur_specialuserestrictiond(array_agg(object_id), 0);
        -- delete ur_exceptionalfloorareara
        WHEN objectclass_id = 60312 THEN
          dummy_id := citydb.del_ur_exceptionalfloorareara(array_agg(object_id), 0);
        -- delete ur_highriseresidentialatt
        WHEN objectclass_id = 60313 THEN
          dummy_id := citydb.del_ur_highriseresidentialatt(array_agg(object_id), 0);
        -- delete ur_heightcontroldistrict
        WHEN objectclass_id = 60314 THEN
          dummy_id := citydb.del_ur_heightcontroldistrict(array_agg(object_id), 0);
        -- delete ur_highlevelusedistrict
        WHEN objectclass_id = 60315 THEN
          dummy_id := citydb.del_ur_highlevelusedistrict(array_agg(object_id), 0);
        -- delete ur_specifiedblock
        WHEN objectclass_id = 60316 THEN
          dummy_id := citydb.del_ur_specifiedblock(array_agg(object_id), 0);
        -- delete ur_specialurbanrenaissanc
        WHEN objectclass_id = 60317 THEN
          dummy_id := citydb.del_ur_specialurbanrenaissanc(array_agg(object_id), 0);
        -- delete ur_districtsandzones
        WHEN objectclass_id = 60318 THEN
          dummy_id := citydb.del_ur_districtsandzones(array_agg(object_id), 0);
        -- delete ur_residentialenvironment
        WHEN objectclass_id = 60319 THEN
          dummy_id := citydb.del_ur_residentialenvironment(array_agg(object_id), 0);
        -- delete ur_specialuseattractiondi
        WHEN objectclass_id = 60320 THEN
          dummy_id := citydb.del_ur_specialuseattractiondi(array_agg(object_id), 0);
        -- delete ur_districtsandzones
        WHEN objectclass_id = 60321 THEN
          dummy_id := citydb.del_ur_districtsandzones(array_agg(object_id), 0);
        -- delete ur_specifieddisasterpreve
        WHEN objectclass_id = 60322 THEN
          dummy_id := citydb.del_ur_specifieddisasterpreve(array_agg(object_id), 0);
        -- delete ur_landscapezone
        WHEN objectclass_id = 60323 THEN
          dummy_id := citydb.del_ur_landscapezone(array_agg(object_id), 0);
        -- delete ur_scenicdistrict
        WHEN objectclass_id = 60324 THEN
          dummy_id := citydb.del_ur_scenicdistrict(array_agg(object_id), 0);
        -- delete ur_districtsandzones
        WHEN objectclass_id = 60325 THEN
          dummy_id := citydb.del_ur_districtsandzones(array_agg(object_id), 0);
        -- delete ur_portzone
        WHEN objectclass_id = 60326 THEN
          dummy_id := citydb.del_ur_portzone(array_agg(object_id), 0);
        -- delete ur_districtsandzones
        WHEN objectclass_id = 60327 THEN
          dummy_id := citydb.del_ur_districtsandzones(array_agg(object_id), 0);
        -- delete ur_districtsandzones
        WHEN objectclass_id = 60328 THEN
          dummy_id := citydb.del_ur_districtsandzones(array_agg(object_id), 0);
        -- delete ur_districtsandzones
        WHEN objectclass_id = 60329 THEN
          dummy_id := citydb.del_ur_districtsandzones(array_agg(object_id), 0);
        -- delete ur_specialgreenspaceconse
        WHEN objectclass_id = 60330 THEN
          dummy_id := citydb.del_ur_specialgreenspaceconse(array_agg(object_id), 0);
        -- delete ur_treeplantingdistrict
        WHEN objectclass_id = 60331 THEN
          dummy_id := citydb.del_ur_treeplantingdistrict(array_agg(object_id), 0);
        -- delete ur_distributionbusinesszo
        WHEN objectclass_id = 60332 THEN
          dummy_id := citydb.del_ur_distributionbusinesszo(array_agg(object_id), 0);
        -- delete ur_productivegreenzone
        WHEN objectclass_id = 60333 THEN
          dummy_id := citydb.del_ur_productivegreenzone(array_agg(object_id), 0);
        -- delete ur_districtsandzones
        WHEN objectclass_id = 60334 THEN
          dummy_id := citydb.del_ur_districtsandzones(array_agg(object_id), 0);
        -- delete ur_districtsandzones
        WHEN objectclass_id = 60335 THEN
          dummy_id := citydb.del_ur_districtsandzones(array_agg(object_id), 0);
        -- delete ur_urbanredevelopmentprom
        WHEN objectclass_id = 60336 THEN
          dummy_id := citydb.del_ur_urbanredevelopmentprom(array_agg(object_id), 0);
        -- delete ur_projectpromotionarea
        WHEN objectclass_id = 60337 THEN
          dummy_id := citydb.del_ur_projectpromotionarea(array_agg(object_id), 0);
        -- delete ur_projectpromotionarea
        WHEN objectclass_id = 60338 THEN
          dummy_id := citydb.del_ur_projectpromotionarea(array_agg(object_id), 0);
        -- delete ur_projectpromotionarea
        WHEN objectclass_id = 60339 THEN
          dummy_id := citydb.del_ur_projectpromotionarea(array_agg(object_id), 0);
        -- delete ur_landreadjustmentprojec
        WHEN objectclass_id = 60340 THEN
          dummy_id := citydb.del_ur_landreadjustmentprojec(array_agg(object_id), 0);
        -- delete ur_newhousingandurbandeve
        WHEN objectclass_id = 60341 THEN
          dummy_id := citydb.del_ur_newhousingandurbandeve(array_agg(object_id), 0);
        -- delete ur_industrialparkdevelopm
        WHEN objectclass_id = 60342 THEN
          dummy_id := citydb.del_ur_industrialparkdevelopm(array_agg(object_id), 0);
        -- delete ur_urbanredevelopmentproj
        WHEN objectclass_id = 60343 THEN
          dummy_id := citydb.del_ur_urbanredevelopmentproj(array_agg(object_id), 0);
        -- delete ur_newurbaninfrastructure
        WHEN objectclass_id = 60344 THEN
          dummy_id := citydb.del_ur_newurbaninfrastructure(array_agg(object_id), 0);
        -- delete ur_residentialblockconstr
        WHEN objectclass_id = 60345 THEN
          dummy_id := citydb.del_ur_residentialblockconstr(array_agg(object_id), 0);
        -- delete ur_disasterpreventionbloc
        WHEN objectclass_id = 60346 THEN
          dummy_id := citydb.del_ur_disasterpreventionbloc(array_agg(object_id), 0);
        -- delete ur_urbanrenewalproject
        WHEN objectclass_id = 60347 THEN
          dummy_id := citydb.del_ur_urbanrenewalproject(array_agg(object_id), 0);
        -- delete ur_scheduledareaforurband
        WHEN objectclass_id = 60348 THEN
          dummy_id := citydb.del_ur_scheduledareaforurband(array_agg(object_id), 0);
        -- delete ur_scheduledareaforurband
        WHEN objectclass_id = 60349 THEN
          dummy_id := citydb.del_ur_scheduledareaforurband(array_agg(object_id), 0);
        -- delete ur_scheduledareaforurband
        WHEN objectclass_id = 60350 THEN
          dummy_id := citydb.del_ur_scheduledareaforurband(array_agg(object_id), 0);
        -- delete ur_scheduledareaforurband
        WHEN objectclass_id = 60351 THEN
          dummy_id := citydb.del_ur_scheduledareaforurband(array_agg(object_id), 0);
        -- delete ur_scheduledareaforurband
        WHEN objectclass_id = 60352 THEN
          dummy_id := citydb.del_ur_scheduledareaforurband(array_agg(object_id), 0);
        -- delete ur_scheduledareaforurband
        WHEN objectclass_id = 60353 THEN
          dummy_id := citydb.del_ur_scheduledareaforurband(array_agg(object_id), 0);
        -- delete ur_trafficfacility
        WHEN objectclass_id = 60354 THEN
          dummy_id := citydb.del_ur_trafficfacility(array_agg(object_id), 0);
        -- delete ur_openspaceforpublicuse
        WHEN objectclass_id = 60355 THEN
          dummy_id := citydb.del_ur_openspaceforpublicuse(array_agg(object_id), 0);
        -- delete ur_supplyfacility
        WHEN objectclass_id = 60356 THEN
          dummy_id := citydb.del_ur_supplyfacility(array_agg(object_id), 0);
        -- delete ur_treatmentfacility
        WHEN objectclass_id = 60357 THEN
          dummy_id := citydb.del_ur_treatmentfacility(array_agg(object_id), 0);
        -- delete ur_waterway_2
        WHEN objectclass_id = 60358 THEN
          dummy_id := citydb.del_ur_waterway_2(array_agg(object_id), 0);
        -- delete ur_urbanfacility
        WHEN objectclass_id = 60359 THEN
          dummy_id := citydb.del_ur_urbanfacility(array_agg(object_id), 0);
        -- delete ur_urbanfacility
        WHEN objectclass_id = 60360 THEN
          dummy_id := citydb.del_ur_urbanfacility(array_agg(object_id), 0);
        -- delete ur_urbanfacility
        WHEN objectclass_id = 60361 THEN
          dummy_id := citydb.del_ur_urbanfacility(array_agg(object_id), 0);
        -- delete ur_urbanfacility
        WHEN objectclass_id = 60362 THEN
          dummy_id := citydb.del_ur_urbanfacility(array_agg(object_id), 0);
        -- delete ur_collectivehousingfacil
        WHEN objectclass_id = 60363 THEN
          dummy_id := citydb.del_ur_collectivehousingfacil(array_agg(object_id), 0);
        -- delete ur_collectivegovernmentan
        WHEN objectclass_id = 60364 THEN
          dummy_id := citydb.del_ur_collectivegovernmentan(array_agg(object_id), 0);
        -- delete ur_collectiveurbandisaste
        WHEN objectclass_id = 60365 THEN
          dummy_id := citydb.del_ur_collectiveurbandisaste(array_agg(object_id), 0);
        -- delete ur_distributionbusinesspa
        WHEN objectclass_id = 60366 THEN
          dummy_id := citydb.del_ur_distributionbusinesspa(array_agg(object_id), 0);
        -- delete ur_urbanfacilitystipulate
        WHEN objectclass_id = 60367 THEN
          dummy_id := citydb.del_ur_urbanfacilitystipulate(array_agg(object_id), 0);
        -- delete ur_collectivefacilitiesfo
        WHEN objectclass_id = 60368 THEN
          dummy_id := citydb.del_ur_collectivefacilitiesfo(array_agg(object_id), 0);
        -- delete ur_collectivefacilities_2
        WHEN objectclass_id = 60369 THEN
          dummy_id := citydb.del_ur_collectivefacilities_2(array_agg(object_id), 0);
        -- delete ur_collectivefacilities_3
        WHEN objectclass_id = 60370 THEN
          dummy_id := citydb.del_ur_collectivefacilities_3(array_agg(object_id), 0);
        -- delete ur_districtplan
        WHEN objectclass_id = 60371 THEN
          dummy_id := citydb.del_ur_districtplan(array_agg(object_id), 0);
        -- delete ur_disasterpreventionbl_2
        WHEN objectclass_id = 60372 THEN
          dummy_id := citydb.del_ur_disasterpreventionbl_2(array_agg(object_id), 0);
        -- delete ur_historicscenerymainten
        WHEN objectclass_id = 60373 THEN
          dummy_id := citydb.del_ur_historicscenerymainten(array_agg(object_id), 0);
        -- delete ur_roadsidedistrictplan
        WHEN objectclass_id = 60374 THEN
          dummy_id := citydb.del_ur_roadsidedistrictplan(array_agg(object_id), 0);
        -- delete ur_abstractdistrictplan
        WHEN objectclass_id = 60375 THEN
          dummy_id := citydb.del_ur_abstractdistrictplan(array_agg(object_id), 0);
        -- delete ur_districtdevelopmentpla
        WHEN objectclass_id = 60376 THEN
          dummy_id := citydb.del_ur_districtdevelopmentpla(array_agg(object_id), 0);
        -- delete ur_districtdevelopmentpla
        WHEN objectclass_id = 60377 THEN
          dummy_id := citydb.del_ur_districtdevelopmentpla(array_agg(object_id), 0);
        -- delete ur_districtdevelopmentpla
        WHEN objectclass_id = 60378 THEN
          dummy_id := citydb.del_ur_districtdevelopmentpla(array_agg(object_id), 0);
        -- delete ur_roadsidedistrictimprov
        WHEN objectclass_id = 60379 THEN
          dummy_id := citydb.del_ur_roadsidedistrictimprov(array_agg(object_id), 0);
        -- delete ur_ruraldistrictimproveme
        WHEN objectclass_id = 60380 THEN
          dummy_id := citydb.del_ur_ruraldistrictimproveme(array_agg(object_id), 0);
        -- delete ur_zone
        WHEN objectclass_id = 60381 THEN
          dummy_id := citydb.del_ur_zone(array_agg(object_id), 0);
        -- delete ur_zone
        WHEN objectclass_id = 60382 THEN
          dummy_id := citydb.del_ur_zone(array_agg(object_id), 0);
        -- delete ur_specifiedurgenturbanre
        WHEN objectclass_id = 60383 THEN
          dummy_id := citydb.del_ur_specifiedurgenturbanre(array_agg(object_id), 0);
        -- delete ur_urbanfacilitystipulate
        WHEN objectclass_id = 60384 THEN
          dummy_id := citydb.del_ur_urbanfacilitystipulate(array_agg(object_id), 0);
        -- delete ur_urbanfacilitystipulate
        WHEN objectclass_id = 60385 THEN
          dummy_id := citydb.del_ur_urbanfacilitystipulate(array_agg(object_id), 0);
        -- delete ur_urbanfacilitystipulate
        WHEN objectclass_id = 60386 THEN
          dummy_id := citydb.del_ur_urbanfacilitystipulate(array_agg(object_id), 0);
        -- delete ur_urbanfacilitystipulate
        WHEN objectclass_id = 60387 THEN
          dummy_id := citydb.del_ur_urbanfacilitystipulate(array_agg(object_id), 0);
        -- delete ur_urbanfacilitystipulate
        WHEN objectclass_id = 60388 THEN
          dummy_id := citydb.del_ur_urbanfacilitystipulate(array_agg(object_id), 0);
        -- delete ur_urbanfacilitystipulate
        WHEN objectclass_id = 60389 THEN
          dummy_id := citydb.del_ur_urbanfacilitystipulate(array_agg(object_id), 0);
        -- delete ur_urbanfacilitystipulate
        WHEN objectclass_id = 60390 THEN
          dummy_id := citydb.del_ur_urbanfacilitystipulate(array_agg(object_id), 0);
        ELSE
          dummy_id := NULL;
      END CASE;

      IF dummy_id = object_id THEN
        deleted_child_ids := array_append(deleted_child_ids, dummy_id);
      END IF;
    END LOOP;
  END IF;

  -- delete citydb.cityobjects
  WITH delete_objects AS (
    DELETE FROM
      citydb.cityobject t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_cityobject(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_cityobject(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_cityobject_genericattrib(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  surface_geometry_ids bigint[] := '{}';
BEGIN
  -- delete referenced parts
  PERFORM
    citydb.del_cityobject_genericattrib(array_agg(t.id))
  FROM
    citydb.cityobject_genericattrib t,
    unnest($1) a(a_id)
  WHERE
    t.parent_genattrib_id = a.a_id
    AND t.id <> a.a_id;

  -- delete referenced parts
  PERFORM
    citydb.del_cityobject_genericattrib(array_agg(t.id))
  FROM
    citydb.cityobject_genericattrib t,
    unnest($1) a(a_id)
  WHERE
    t.root_genattrib_id = a.a_id
    AND t.id <> a.a_id;

  -- delete citydb.cityobject_genericattribs
  WITH delete_objects AS (
    DELETE FROM
      citydb.cityobject_genericattrib t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      surface_geometry_id
  )
  SELECT
    array_agg(id),
    array_agg(surface_geometry_id)
  INTO
    deleted_ids,
    surface_geometry_ids
  FROM
    delete_objects;

  -- delete citydb.surface_geometry(s)
  IF -1 = ALL(surface_geometry_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_surface_geometry(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(surface_geometry_ids) AS a_id) a;
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_cityobject_genericattrib(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_cityobject_genericattrib(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_cityobjectgroup(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  cityobject_ids bigint[] := '{}';
  surface_geometry_ids bigint[] := '{}';
BEGIN
  -- delete references to cityobjects
  WITH del_cityobject_refs AS (
    DELETE FROM
      citydb.group_to_cityobject t
    USING
      unnest($1) a(a_id)
    WHERE
      t.cityobjectgroup_id = a.a_id
    RETURNING
      t.cityobject_id
  )
  SELECT
    array_agg(cityobject_id)
  INTO
    cityobject_ids
  FROM
    del_cityobject_refs;

  -- delete citydb.cityobject(s)
  IF -1 = ALL(cityobject_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_cityobject(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(cityobject_ids) AS a_id) a
    LEFT JOIN
      citydb.cityobject_member n1
      ON n1.cityobject_id  = a.a_id
    LEFT JOIN
      citydb.group_to_cityobject n2
      ON n2.cityobject_id  = a.a_id
    WHERE n1.cityobject_id IS NULL
      AND n2.cityobject_id IS NULL;
  END IF;

  -- delete ur_cityobjectgroups
  PERFORM citydb.del_ur_cityobjectgroup($1, 1);

  -- delete ur_cityobjectgroup_1s
  PERFORM citydb.del_ur_cityobjectgroup_1($1, 1);

  -- delete ur_cityobjectgroup_2s
  PERFORM citydb.del_ur_cityobjectgroup_2($1, 1);

  -- delete ur_cityobjectgroup_3s
  PERFORM citydb.del_ur_cityobjectgroup_3($1, 1);

  -- delete citydb.cityobjectgroups
  WITH delete_objects AS (
    DELETE FROM
      citydb.cityobjectgroup t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      brep_id
  )
  SELECT
    array_agg(id),
    array_agg(brep_id)
  INTO
    deleted_ids,
    surface_geometry_ids
  FROM
    delete_objects;

  -- delete citydb.surface_geometry(s)
  IF -1 = ALL(surface_geometry_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_surface_geometry(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(surface_geometry_ids) AS a_id) a;
  END IF;

  IF $2 <> 1 THEN
    -- delete cityobject
    PERFORM citydb.del_cityobject(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_cityobjectgroup(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_cityobjectgroup(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_cityobjects_by_lineage(lineage_value TEXT, objectclass_id INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
-- Function for deleting cityobjects by lineage value
DECLARE
  deleted_ids bigint[] := '{}';
BEGIN
  IF $2 = 0 THEN
    SELECT array_agg(c.id) FROM
      citydb.cityobject c
    INTO
      deleted_ids
    WHERE
      c.lineage = $1;
  ELSE
    SELECT array_agg(c.id) FROM
      citydb.cityobject c
    INTO
      deleted_ids
    WHERE
      c.lineage = $1 AND c.objectclass_id = $2;
  END IF;

  IF -1 = ALL(deleted_ids) IS NOT NULL THEN
    PERFORM citydb.del_cityobject(deleted_ids);
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_external_reference(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.external_references
  WITH delete_objects AS (
    DELETE FROM
      citydb.external_reference t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_external_reference(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_external_reference(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_generic_cityobject(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  implicit_geometry_ids bigint[] := '{}';
  surface_geometry_ids bigint[] := '{}';
BEGIN
  -- delete citydb.generic_cityobjects
  WITH delete_objects AS (
    DELETE FROM
      citydb.generic_cityobject t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      lod0_implicit_rep_id,
      lod1_implicit_rep_id,
      lod2_implicit_rep_id,
      lod3_implicit_rep_id,
      lod4_implicit_rep_id,
      lod0_brep_id,
      lod1_brep_id,
      lod2_brep_id,
      lod3_brep_id,
      lod4_brep_id
  )
  SELECT
    array_agg(id),
    array_agg(lod0_implicit_rep_id) ||
    array_agg(lod1_implicit_rep_id) ||
    array_agg(lod2_implicit_rep_id) ||
    array_agg(lod3_implicit_rep_id) ||
    array_agg(lod4_implicit_rep_id),
    array_agg(lod0_brep_id) ||
    array_agg(lod1_brep_id) ||
    array_agg(lod2_brep_id) ||
    array_agg(lod3_brep_id) ||
    array_agg(lod4_brep_id)
  INTO
    deleted_ids,
    implicit_geometry_ids,
    surface_geometry_ids
  FROM
    delete_objects;

  -- delete citydb.implicit_geometry(s)
  IF -1 = ALL(implicit_geometry_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_implicit_geometry(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(implicit_geometry_ids) AS a_id) a
    LEFT JOIN
      citydb.bridge_constr_element n1
      ON n1.lod1_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_constr_element n2
      ON n2.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_constr_element n3
      ON n3.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_constr_element n4
      ON n4.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_furniture n5
      ON n5.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_installation n6
      ON n6.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_installation n7
      ON n7.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_installation n8
      ON n8.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_opening n9
      ON n9.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_opening n10
      ON n10.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.building_furniture n11
      ON n11.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.building_installation n12
      ON n12.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.building_installation n13
      ON n13.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.building_installation n14
      ON n14.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.city_furniture n15
      ON n15.lod1_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.city_furniture n16
      ON n16.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.city_furniture n17
      ON n17.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.city_furniture n18
      ON n18.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n19
      ON n19.lod0_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n20
      ON n20.lod1_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n21
      ON n21.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n22
      ON n22.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n23
      ON n23.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.opening n24
      ON n24.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.opening n25
      ON n25.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.solitary_vegetat_object n26
      ON n26.lod1_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.solitary_vegetat_object n27
      ON n27.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.solitary_vegetat_object n28
      ON n28.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.solitary_vegetat_object n29
      ON n29.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_furniture n30
      ON n30.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_installation n31
      ON n31.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_installation n32
      ON n32.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_installation n33
      ON n33.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_opening n34
      ON n34.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_opening n35
      ON n35.lod4_implicit_rep_id  = a.a_id
    WHERE n1.lod1_implicit_rep_id IS NULL
      AND n2.lod2_implicit_rep_id IS NULL
      AND n3.lod3_implicit_rep_id IS NULL
      AND n4.lod4_implicit_rep_id IS NULL
      AND n5.lod4_implicit_rep_id IS NULL
      AND n6.lod2_implicit_rep_id IS NULL
      AND n7.lod3_implicit_rep_id IS NULL
      AND n8.lod4_implicit_rep_id IS NULL
      AND n9.lod3_implicit_rep_id IS NULL
      AND n10.lod4_implicit_rep_id IS NULL
      AND n11.lod4_implicit_rep_id IS NULL
      AND n12.lod2_implicit_rep_id IS NULL
      AND n13.lod3_implicit_rep_id IS NULL
      AND n14.lod4_implicit_rep_id IS NULL
      AND n15.lod1_implicit_rep_id IS NULL
      AND n16.lod2_implicit_rep_id IS NULL
      AND n17.lod3_implicit_rep_id IS NULL
      AND n18.lod4_implicit_rep_id IS NULL
      AND n19.lod0_implicit_rep_id IS NULL
      AND n20.lod1_implicit_rep_id IS NULL
      AND n21.lod2_implicit_rep_id IS NULL
      AND n22.lod3_implicit_rep_id IS NULL
      AND n23.lod4_implicit_rep_id IS NULL
      AND n24.lod3_implicit_rep_id IS NULL
      AND n25.lod4_implicit_rep_id IS NULL
      AND n26.lod1_implicit_rep_id IS NULL
      AND n27.lod2_implicit_rep_id IS NULL
      AND n28.lod3_implicit_rep_id IS NULL
      AND n29.lod4_implicit_rep_id IS NULL
      AND n30.lod4_implicit_rep_id IS NULL
      AND n31.lod2_implicit_rep_id IS NULL
      AND n32.lod3_implicit_rep_id IS NULL
      AND n33.lod4_implicit_rep_id IS NULL
      AND n34.lod3_implicit_rep_id IS NULL
      AND n35.lod4_implicit_rep_id IS NULL;
  END IF;

  -- delete citydb.surface_geometry(s)
  IF -1 = ALL(surface_geometry_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_surface_geometry(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(surface_geometry_ids) AS a_id) a;
  END IF;

  IF $2 <> 1 THEN
    -- delete cityobject
    PERFORM citydb.del_cityobject(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_generic_cityobject(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_generic_cityobject(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_grid_coverage(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.grid_coverages
  WITH delete_objects AS (
    DELETE FROM
      citydb.grid_coverage t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_grid_coverage(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_grid_coverage(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_implicit_geometry(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  surface_geometry_ids bigint[] := '{}';
BEGIN
  -- delete citydb.implicit_geometrys
  WITH delete_objects AS (
    DELETE FROM
      citydb.implicit_geometry t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      relative_brep_id
  )
  SELECT
    array_agg(id),
    array_agg(relative_brep_id)
  INTO
    deleted_ids,
    surface_geometry_ids
  FROM
    delete_objects;

  -- delete citydb.surface_geometry(s)
  IF -1 = ALL(surface_geometry_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_surface_geometry(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(surface_geometry_ids) AS a_id) a;
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_implicit_geometry(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_implicit_geometry(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_land_use(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  surface_geometry_ids bigint[] := '{}';
BEGIN
  -- delete ur_land_uses
  PERFORM citydb.del_ur_land_use($1, 1);

  IF $2 <> 2 THEN
    FOR rec IN
      SELECT
        co.id, co.objectclass_id
      FROM
        citydb.cityobject co, unnest($1) a(a_id)
      WHERE
        co.id = a.a_id
    LOOP
      object_id := rec.id::bigint;
      objectclass_id := rec.objectclass_id::integer;
      CASE
        -- delete ur_publicland
        WHEN objectclass_id = 60179 THEN
          dummy_id := citydb.del_ur_publicland(array_agg(object_id), 1);
        ELSE
          dummy_id := NULL;
      END CASE;

      IF dummy_id = object_id THEN
        deleted_child_ids := array_append(deleted_child_ids, dummy_id);
      END IF;
    END LOOP;
  END IF;

  -- delete citydb.land_uses
  WITH delete_objects AS (
    DELETE FROM
      citydb.land_use t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      lod0_multi_surface_id,
      lod1_multi_surface_id,
      lod2_multi_surface_id,
      lod3_multi_surface_id,
      lod4_multi_surface_id
  )
  SELECT
    array_agg(id),
    array_agg(lod0_multi_surface_id) ||
    array_agg(lod1_multi_surface_id) ||
    array_agg(lod2_multi_surface_id) ||
    array_agg(lod3_multi_surface_id) ||
    array_agg(lod4_multi_surface_id)
  INTO
    deleted_ids,
    surface_geometry_ids
  FROM
    delete_objects;

  -- delete citydb.surface_geometry(s)
  IF -1 = ALL(surface_geometry_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_surface_geometry(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(surface_geometry_ids) AS a_id) a;
  END IF;

  IF $2 <> 1 THEN
    -- delete cityobject
    PERFORM citydb.del_cityobject(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_land_use(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_land_use(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_masspoint_relief(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.masspoint_reliefs
  WITH delete_objects AS (
    DELETE FROM
      citydb.masspoint_relief t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete relief_component
    PERFORM citydb.del_relief_component(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_masspoint_relief(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_masspoint_relief(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_opening(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  implicit_geometry_ids bigint[] := '{}';
  surface_geometry_ids bigint[] := '{}';
  address_ids bigint[] := '{}';
BEGIN
  -- delete ur_openings
  PERFORM citydb.del_ur_opening($1, 1);

  -- delete citydb.openings
  WITH delete_objects AS (
    DELETE FROM
      citydb.opening t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      lod3_implicit_rep_id,
      lod4_implicit_rep_id,
      lod3_multi_surface_id,
      lod4_multi_surface_id,
      address_id
  )
  SELECT
    array_agg(id),
    array_agg(lod3_implicit_rep_id) ||
    array_agg(lod4_implicit_rep_id),
    array_agg(lod3_multi_surface_id) ||
    array_agg(lod4_multi_surface_id),
    array_agg(address_id)
  INTO
    deleted_ids,
    implicit_geometry_ids,
    surface_geometry_ids,
    address_ids
  FROM
    delete_objects;

  -- delete citydb.implicit_geometry(s)
  IF -1 = ALL(implicit_geometry_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_implicit_geometry(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(implicit_geometry_ids) AS a_id) a
    LEFT JOIN
      citydb.bridge_constr_element n1
      ON n1.lod1_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_constr_element n2
      ON n2.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_constr_element n3
      ON n3.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_constr_element n4
      ON n4.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_furniture n5
      ON n5.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_installation n6
      ON n6.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_installation n7
      ON n7.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_installation n8
      ON n8.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_opening n9
      ON n9.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_opening n10
      ON n10.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.building_furniture n11
      ON n11.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.building_installation n12
      ON n12.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.building_installation n13
      ON n13.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.building_installation n14
      ON n14.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.city_furniture n15
      ON n15.lod1_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.city_furniture n16
      ON n16.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.city_furniture n17
      ON n17.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.city_furniture n18
      ON n18.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n19
      ON n19.lod0_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n20
      ON n20.lod1_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n21
      ON n21.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n22
      ON n22.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n23
      ON n23.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.opening n24
      ON n24.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.opening n25
      ON n25.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.solitary_vegetat_object n26
      ON n26.lod1_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.solitary_vegetat_object n27
      ON n27.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.solitary_vegetat_object n28
      ON n28.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.solitary_vegetat_object n29
      ON n29.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_furniture n30
      ON n30.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_installation n31
      ON n31.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_installation n32
      ON n32.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_installation n33
      ON n33.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_opening n34
      ON n34.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_opening n35
      ON n35.lod4_implicit_rep_id  = a.a_id
    WHERE n1.lod1_implicit_rep_id IS NULL
      AND n2.lod2_implicit_rep_id IS NULL
      AND n3.lod3_implicit_rep_id IS NULL
      AND n4.lod4_implicit_rep_id IS NULL
      AND n5.lod4_implicit_rep_id IS NULL
      AND n6.lod2_implicit_rep_id IS NULL
      AND n7.lod3_implicit_rep_id IS NULL
      AND n8.lod4_implicit_rep_id IS NULL
      AND n9.lod3_implicit_rep_id IS NULL
      AND n10.lod4_implicit_rep_id IS NULL
      AND n11.lod4_implicit_rep_id IS NULL
      AND n12.lod2_implicit_rep_id IS NULL
      AND n13.lod3_implicit_rep_id IS NULL
      AND n14.lod4_implicit_rep_id IS NULL
      AND n15.lod1_implicit_rep_id IS NULL
      AND n16.lod2_implicit_rep_id IS NULL
      AND n17.lod3_implicit_rep_id IS NULL
      AND n18.lod4_implicit_rep_id IS NULL
      AND n19.lod0_implicit_rep_id IS NULL
      AND n20.lod1_implicit_rep_id IS NULL
      AND n21.lod2_implicit_rep_id IS NULL
      AND n22.lod3_implicit_rep_id IS NULL
      AND n23.lod4_implicit_rep_id IS NULL
      AND n24.lod3_implicit_rep_id IS NULL
      AND n25.lod4_implicit_rep_id IS NULL
      AND n26.lod1_implicit_rep_id IS NULL
      AND n27.lod2_implicit_rep_id IS NULL
      AND n28.lod3_implicit_rep_id IS NULL
      AND n29.lod4_implicit_rep_id IS NULL
      AND n30.lod4_implicit_rep_id IS NULL
      AND n31.lod2_implicit_rep_id IS NULL
      AND n32.lod3_implicit_rep_id IS NULL
      AND n33.lod4_implicit_rep_id IS NULL
      AND n34.lod3_implicit_rep_id IS NULL
      AND n35.lod4_implicit_rep_id IS NULL;
  END IF;

  -- delete citydb.surface_geometry(s)
  IF -1 = ALL(surface_geometry_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_surface_geometry(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(surface_geometry_ids) AS a_id) a;
  END IF;

  -- delete citydb.address(s)
  IF -1 = ALL(address_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_address(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(address_ids) AS a_id) a
    LEFT JOIN
      citydb.address_to_bridge n1
      ON n1.address_id  = a.a_id
    LEFT JOIN
      citydb.address_to_building n2
      ON n2.address_id  = a.a_id
    LEFT JOIN
      citydb.bridge_opening n3
      ON n3.address_id  = a.a_id
    LEFT JOIN
      citydb.opening n4
      ON n4.address_id  = a.a_id
    WHERE n1.address_id IS NULL
      AND n2.address_id IS NULL
      AND n3.address_id IS NULL
      AND n4.address_id IS NULL;
  END IF;

  IF $2 <> 1 THEN
    -- delete cityobject
    PERFORM citydb.del_cityobject(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_opening(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_opening(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_plant_cover(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  surface_geometry_ids bigint[] := '{}';
BEGIN
  -- delete citydb.plant_covers
  WITH delete_objects AS (
    DELETE FROM
      citydb.plant_cover t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      lod1_multi_surface_id,
      lod2_multi_surface_id,
      lod3_multi_surface_id,
      lod4_multi_surface_id,
      lod1_multi_solid_id,
      lod2_multi_solid_id,
      lod3_multi_solid_id,
      lod4_multi_solid_id
  )
  SELECT
    array_agg(id),
    array_agg(lod1_multi_surface_id) ||
    array_agg(lod2_multi_surface_id) ||
    array_agg(lod3_multi_surface_id) ||
    array_agg(lod4_multi_surface_id) ||
    array_agg(lod1_multi_solid_id) ||
    array_agg(lod2_multi_solid_id) ||
    array_agg(lod3_multi_solid_id) ||
    array_agg(lod4_multi_solid_id)
  INTO
    deleted_ids,
    surface_geometry_ids
  FROM
    delete_objects;

  -- delete citydb.surface_geometry(s)
  IF -1 = ALL(surface_geometry_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_surface_geometry(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(surface_geometry_ids) AS a_id) a;
  END IF;

  IF $2 <> 1 THEN
    -- delete cityobject
    PERFORM citydb.del_cityobject(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_plant_cover(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_plant_cover(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_raster_relief(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  grid_coverage_ids bigint[] := '{}';
BEGIN
  -- delete citydb.raster_reliefs
  WITH delete_objects AS (
    DELETE FROM
      citydb.raster_relief t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      coverage_id
  )
  SELECT
    array_agg(id),
    array_agg(coverage_id)
  INTO
    deleted_ids,
    grid_coverage_ids
  FROM
    delete_objects;

  -- delete citydb.grid_coverage(s)
  IF -1 = ALL(grid_coverage_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_grid_coverage(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(grid_coverage_ids) AS a_id) a;
  END IF;

  IF $2 <> 1 THEN
    -- delete relief_component
    PERFORM citydb.del_relief_component(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_raster_relief(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_raster_relief(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_relief_component(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete ur_relief_components
  PERFORM citydb.del_ur_relief_component($1, 1);

  IF $2 <> 2 THEN
    FOR rec IN
      SELECT
        co.id, co.objectclass_id
      FROM
        citydb.cityobject co, unnest($1) a(a_id)
      WHERE
        co.id = a.a_id
    LOOP
      object_id := rec.id::bigint;
      objectclass_id := rec.objectclass_id::integer;
      CASE
        -- delete tin_relief
        WHEN objectclass_id = 16 THEN
          dummy_id := citydb.del_tin_relief(array_agg(object_id), 1);
        -- delete masspoint_relief
        WHEN objectclass_id = 17 THEN
          dummy_id := citydb.del_masspoint_relief(array_agg(object_id), 1);
        -- delete breakline_relief
        WHEN objectclass_id = 18 THEN
          dummy_id := citydb.del_breakline_relief(array_agg(object_id), 1);
        -- delete raster_relief
        WHEN objectclass_id = 19 THEN
          dummy_id := citydb.del_raster_relief(array_agg(object_id), 1);
        ELSE
          dummy_id := NULL;
      END CASE;

      IF dummy_id = object_id THEN
        deleted_child_ids := array_append(deleted_child_ids, dummy_id);
      END IF;
    END LOOP;
  END IF;

  -- delete citydb.relief_components
  WITH delete_objects AS (
    DELETE FROM
      citydb.relief_component t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete cityobject
    PERFORM citydb.del_cityobject(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_relief_component(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_relief_component(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_relief_feature(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  relief_component_ids bigint[] := '{}';
BEGIN
  -- delete references to relief_components
  WITH del_relief_component_refs AS (
    DELETE FROM
      citydb.relief_feat_to_rel_comp t
    USING
      unnest($1) a(a_id)
    WHERE
      t.relief_feature_id = a.a_id
    RETURNING
      t.relief_component_id
  )
  SELECT
    array_agg(relief_component_id)
  INTO
    relief_component_ids
  FROM
    del_relief_component_refs;

  -- delete citydb.relief_component(s)
  IF -1 = ALL(relief_component_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_relief_component(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(relief_component_ids) AS a_id) a
    LEFT JOIN
      citydb.relief_feat_to_rel_comp n1
      ON n1.relief_component_id  = a.a_id
    WHERE n1.relief_component_id IS NULL;
  END IF;

  -- delete ur_relief_features
  PERFORM citydb.del_ur_relief_feature($1, 1);

  -- delete citydb.relief_features
  WITH delete_objects AS (
    DELETE FROM
      citydb.relief_feature t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete cityobject
    PERFORM citydb.del_cityobject(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_relief_feature(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_relief_feature(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_room(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  surface_geometry_ids bigint[] := '{}';
BEGIN
  --delete building_furnitures
  PERFORM
    citydb.del_building_furniture(array_agg(t.id))
  FROM
    citydb.building_furniture t,
    unnest($1) a(a_id)
  WHERE
    t.room_id = a.a_id;

  --delete building_installations
  PERFORM
    citydb.del_building_installation(array_agg(t.id))
  FROM
    citydb.building_installation t,
    unnest($1) a(a_id)
  WHERE
    t.room_id = a.a_id;

  --delete thematic_surfaces
  PERFORM
    citydb.del_thematic_surface(array_agg(t.id))
  FROM
    citydb.thematic_surface t,
    unnest($1) a(a_id)
  WHERE
    t.room_id = a.a_id;

  -- delete ur_rooms
  PERFORM citydb.del_ur_room($1, 1);

  -- delete citydb.rooms
  WITH delete_objects AS (
    DELETE FROM
      citydb.room t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      lod4_multi_surface_id,
      lod4_solid_id
  )
  SELECT
    array_agg(id),
    array_agg(lod4_multi_surface_id) ||
    array_agg(lod4_solid_id)
  INTO
    deleted_ids,
    surface_geometry_ids
  FROM
    delete_objects;

  -- delete citydb.surface_geometry(s)
  IF -1 = ALL(surface_geometry_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_surface_geometry(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(surface_geometry_ids) AS a_id) a;
  END IF;

  IF $2 <> 1 THEN
    -- delete cityobject
    PERFORM citydb.del_cityobject(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_room(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_room(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_solitary_vegetat_object(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  implicit_geometry_ids bigint[] := '{}';
  surface_geometry_ids bigint[] := '{}';
BEGIN
  -- delete citydb.solitary_vegetat_objects
  WITH delete_objects AS (
    DELETE FROM
      citydb.solitary_vegetat_object t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      lod1_implicit_rep_id,
      lod2_implicit_rep_id,
      lod3_implicit_rep_id,
      lod4_implicit_rep_id,
      lod1_brep_id,
      lod2_brep_id,
      lod3_brep_id,
      lod4_brep_id
  )
  SELECT
    array_agg(id),
    array_agg(lod1_implicit_rep_id) ||
    array_agg(lod2_implicit_rep_id) ||
    array_agg(lod3_implicit_rep_id) ||
    array_agg(lod4_implicit_rep_id),
    array_agg(lod1_brep_id) ||
    array_agg(lod2_brep_id) ||
    array_agg(lod3_brep_id) ||
    array_agg(lod4_brep_id)
  INTO
    deleted_ids,
    implicit_geometry_ids,
    surface_geometry_ids
  FROM
    delete_objects;

  -- delete citydb.implicit_geometry(s)
  IF -1 = ALL(implicit_geometry_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_implicit_geometry(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(implicit_geometry_ids) AS a_id) a
    LEFT JOIN
      citydb.bridge_constr_element n1
      ON n1.lod1_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_constr_element n2
      ON n2.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_constr_element n3
      ON n3.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_constr_element n4
      ON n4.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_furniture n5
      ON n5.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_installation n6
      ON n6.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_installation n7
      ON n7.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_installation n8
      ON n8.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_opening n9
      ON n9.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_opening n10
      ON n10.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.building_furniture n11
      ON n11.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.building_installation n12
      ON n12.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.building_installation n13
      ON n13.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.building_installation n14
      ON n14.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.city_furniture n15
      ON n15.lod1_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.city_furniture n16
      ON n16.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.city_furniture n17
      ON n17.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.city_furniture n18
      ON n18.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n19
      ON n19.lod0_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n20
      ON n20.lod1_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n21
      ON n21.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n22
      ON n22.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n23
      ON n23.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.opening n24
      ON n24.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.opening n25
      ON n25.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.solitary_vegetat_object n26
      ON n26.lod1_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.solitary_vegetat_object n27
      ON n27.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.solitary_vegetat_object n28
      ON n28.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.solitary_vegetat_object n29
      ON n29.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_furniture n30
      ON n30.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_installation n31
      ON n31.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_installation n32
      ON n32.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_installation n33
      ON n33.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_opening n34
      ON n34.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_opening n35
      ON n35.lod4_implicit_rep_id  = a.a_id
    WHERE n1.lod1_implicit_rep_id IS NULL
      AND n2.lod2_implicit_rep_id IS NULL
      AND n3.lod3_implicit_rep_id IS NULL
      AND n4.lod4_implicit_rep_id IS NULL
      AND n5.lod4_implicit_rep_id IS NULL
      AND n6.lod2_implicit_rep_id IS NULL
      AND n7.lod3_implicit_rep_id IS NULL
      AND n8.lod4_implicit_rep_id IS NULL
      AND n9.lod3_implicit_rep_id IS NULL
      AND n10.lod4_implicit_rep_id IS NULL
      AND n11.lod4_implicit_rep_id IS NULL
      AND n12.lod2_implicit_rep_id IS NULL
      AND n13.lod3_implicit_rep_id IS NULL
      AND n14.lod4_implicit_rep_id IS NULL
      AND n15.lod1_implicit_rep_id IS NULL
      AND n16.lod2_implicit_rep_id IS NULL
      AND n17.lod3_implicit_rep_id IS NULL
      AND n18.lod4_implicit_rep_id IS NULL
      AND n19.lod0_implicit_rep_id IS NULL
      AND n20.lod1_implicit_rep_id IS NULL
      AND n21.lod2_implicit_rep_id IS NULL
      AND n22.lod3_implicit_rep_id IS NULL
      AND n23.lod4_implicit_rep_id IS NULL
      AND n24.lod3_implicit_rep_id IS NULL
      AND n25.lod4_implicit_rep_id IS NULL
      AND n26.lod1_implicit_rep_id IS NULL
      AND n27.lod2_implicit_rep_id IS NULL
      AND n28.lod3_implicit_rep_id IS NULL
      AND n29.lod4_implicit_rep_id IS NULL
      AND n30.lod4_implicit_rep_id IS NULL
      AND n31.lod2_implicit_rep_id IS NULL
      AND n32.lod3_implicit_rep_id IS NULL
      AND n33.lod4_implicit_rep_id IS NULL
      AND n34.lod3_implicit_rep_id IS NULL
      AND n35.lod4_implicit_rep_id IS NULL;
  END IF;

  -- delete citydb.surface_geometry(s)
  IF -1 = ALL(surface_geometry_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_surface_geometry(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(surface_geometry_ids) AS a_id) a;
  END IF;

  IF $2 <> 1 THEN
    -- delete cityobject
    PERFORM citydb.del_cityobject(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_solitary_vegetat_object(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_solitary_vegetat_object(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_surface_data(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  tex_image_ids bigint[] := '{}';
BEGIN
  -- delete citydb.surface_datas
  WITH delete_objects AS (
    DELETE FROM
      citydb.surface_data t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      tex_image_id
  )
  SELECT
    array_agg(id),
    array_agg(tex_image_id)
  INTO
    deleted_ids,
    tex_image_ids
  FROM
    delete_objects;

  -- delete citydb.tex_image(s)
  IF -1 = ALL(tex_image_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_tex_image(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(tex_image_ids) AS a_id) a
    LEFT JOIN
      citydb.surface_data n1
      ON n1.tex_image_id  = a.a_id
    WHERE n1.tex_image_id IS NULL;
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_surface_data(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_surface_data(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_surface_geometry(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete referenced parts
  PERFORM
    citydb.del_surface_geometry(array_agg(t.id))
  FROM
    citydb.surface_geometry t,
    unnest($1) a(a_id)
  WHERE
    t.parent_id = a.a_id
    AND t.id <> a.a_id;

  -- delete referenced parts
  PERFORM
    citydb.del_surface_geometry(array_agg(t.id))
  FROM
    citydb.surface_geometry t,
    unnest($1) a(a_id)
  WHERE
    t.root_id = a.a_id
    AND t.id <> a.a_id;

  -- delete citydb.surface_geometrys
  WITH delete_objects AS (
    DELETE FROM
      citydb.surface_geometry t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_surface_geometry(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_surface_geometry(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_tex_image(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.tex_images
  WITH delete_objects AS (
    DELETE FROM
      citydb.tex_image t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_tex_image(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_tex_image(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_thematic_surface(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  opening_ids bigint[] := '{}';
  surface_geometry_ids bigint[] := '{}';
BEGIN
  -- delete references to openings
  WITH del_opening_refs AS (
    DELETE FROM
      citydb.opening_to_them_surface t
    USING
      unnest($1) a(a_id)
    WHERE
      t.thematic_surface_id = a.a_id
    RETURNING
      t.opening_id
  )
  SELECT
    array_agg(opening_id)
  INTO
    opening_ids
  FROM
    del_opening_refs;

  -- delete citydb.opening(s)
  IF -1 = ALL(opening_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_opening(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(opening_ids) AS a_id) a;
  END IF;

  -- delete ur_thematic_surfaces
  PERFORM citydb.del_ur_thematic_surface($1, 1);

  -- delete citydb.thematic_surfaces
  WITH delete_objects AS (
    DELETE FROM
      citydb.thematic_surface t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      lod2_multi_surface_id,
      lod3_multi_surface_id,
      lod4_multi_surface_id
  )
  SELECT
    array_agg(id),
    array_agg(lod2_multi_surface_id) ||
    array_agg(lod3_multi_surface_id) ||
    array_agg(lod4_multi_surface_id)
  INTO
    deleted_ids,
    surface_geometry_ids
  FROM
    delete_objects;

  -- delete citydb.surface_geometry(s)
  IF -1 = ALL(surface_geometry_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_surface_geometry(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(surface_geometry_ids) AS a_id) a;
  END IF;

  IF $2 <> 1 THEN
    -- delete cityobject
    PERFORM citydb.del_cityobject(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_thematic_surface(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_thematic_surface(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_tin_relief(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  surface_geometry_ids bigint[] := '{}';
BEGIN
  -- delete citydb.tin_reliefs
  WITH delete_objects AS (
    DELETE FROM
      citydb.tin_relief t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      surface_geometry_id
  )
  SELECT
    array_agg(id),
    array_agg(surface_geometry_id)
  INTO
    deleted_ids,
    surface_geometry_ids
  FROM
    delete_objects;

  -- delete citydb.surface_geometry(s)
  IF -1 = ALL(surface_geometry_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_surface_geometry(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(surface_geometry_ids) AS a_id) a;
  END IF;

  IF $2 <> 1 THEN
    -- delete relief_component
    PERFORM citydb.del_relief_component(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_tin_relief(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_tin_relief(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_traffic_area(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  surface_geometry_ids bigint[] := '{}';
BEGIN
  -- delete ur_traffic_areas
  PERFORM citydb.del_ur_traffic_area($1, 1);

  -- delete citydb.traffic_areas
  WITH delete_objects AS (
    DELETE FROM
      citydb.traffic_area t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      lod2_multi_surface_id,
      lod3_multi_surface_id,
      lod4_multi_surface_id
  )
  SELECT
    array_agg(id),
    array_agg(lod2_multi_surface_id) ||
    array_agg(lod3_multi_surface_id) ||
    array_agg(lod4_multi_surface_id)
  INTO
    deleted_ids,
    surface_geometry_ids
  FROM
    delete_objects;

  -- delete citydb.surface_geometry(s)
  IF -1 = ALL(surface_geometry_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_surface_geometry(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(surface_geometry_ids) AS a_id) a;
  END IF;

  IF $2 <> 1 THEN
    -- delete cityobject
    PERFORM citydb.del_cityobject(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_traffic_area(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_traffic_area(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_transportation_complex(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  surface_geometry_ids bigint[] := '{}';
BEGIN
  --delete traffic_areas
  PERFORM
    citydb.del_traffic_area(array_agg(t.id))
  FROM
    citydb.traffic_area t,
    unnest($1) a(a_id)
  WHERE
    t.transportation_complex_id = a.a_id;

  -- delete ur_transportation_complexs
  PERFORM citydb.del_ur_transportation_complex($1, 1);

  IF $2 <> 2 THEN
    FOR rec IN
      SELECT
        co.id, co.objectclass_id
      FROM
        citydb.cityobject co, unnest($1) a(a_id)
      WHERE
        co.id = a.a_id
    LOOP
      object_id := rec.id::bigint;
      objectclass_id := rec.objectclass_id::integer;
      CASE
        -- delete ur_waterway
        WHEN objectclass_id = 60084 THEN
          dummy_id := citydb.del_ur_waterway(array_agg(object_id), 1);
        ELSE
          dummy_id := NULL;
      END CASE;

      IF dummy_id = object_id THEN
        deleted_child_ids := array_append(deleted_child_ids, dummy_id);
      END IF;
    END LOOP;
  END IF;

  -- delete citydb.transportation_complexs
  WITH delete_objects AS (
    DELETE FROM
      citydb.transportation_complex t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      lod1_multi_surface_id,
      lod2_multi_surface_id,
      lod3_multi_surface_id,
      lod4_multi_surface_id
  )
  SELECT
    array_agg(id),
    array_agg(lod1_multi_surface_id) ||
    array_agg(lod2_multi_surface_id) ||
    array_agg(lod3_multi_surface_id) ||
    array_agg(lod4_multi_surface_id)
  INTO
    deleted_ids,
    surface_geometry_ids
  FROM
    delete_objects;

  -- delete citydb.surface_geometry(s)
  IF -1 = ALL(surface_geometry_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_surface_geometry(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(surface_geometry_ids) AS a_id) a;
  END IF;

  IF $2 <> 1 THEN
    -- delete cityobject
    PERFORM citydb.del_cityobject(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_transportation_complex(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_transportation_complex(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_tunnel(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  surface_geometry_ids bigint[] := '{}';
BEGIN
  -- delete referenced parts
  PERFORM
    citydb.del_tunnel(array_agg(t.id))
  FROM
    citydb.tunnel t,
    unnest($1) a(a_id)
  WHERE
    t.tunnel_parent_id = a.a_id
    AND t.id <> a.a_id;

  -- delete referenced parts
  PERFORM
    citydb.del_tunnel(array_agg(t.id))
  FROM
    citydb.tunnel t,
    unnest($1) a(a_id)
  WHERE
    t.tunnel_root_id = a.a_id
    AND t.id <> a.a_id;

  --delete tunnel_hollow_spaces
  PERFORM
    citydb.del_tunnel_hollow_space(array_agg(t.id))
  FROM
    citydb.tunnel_hollow_space t,
    unnest($1) a(a_id)
  WHERE
    t.tunnel_id = a.a_id;

  --delete tunnel_installations
  PERFORM
    citydb.del_tunnel_installation(array_agg(t.id))
  FROM
    citydb.tunnel_installation t,
    unnest($1) a(a_id)
  WHERE
    t.tunnel_id = a.a_id;

  --delete tunnel_thematic_surfaces
  PERFORM
    citydb.del_tunnel_thematic_surface(array_agg(t.id))
  FROM
    citydb.tunnel_thematic_surface t,
    unnest($1) a(a_id)
  WHERE
    t.tunnel_id = a.a_id;

  -- delete ur_tunnels
  PERFORM citydb.del_ur_tunnel($1, 1);

  -- delete citydb.tunnels
  WITH delete_objects AS (
    DELETE FROM
      citydb.tunnel t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      lod1_multi_surface_id,
      lod2_multi_surface_id,
      lod3_multi_surface_id,
      lod4_multi_surface_id,
      lod1_solid_id,
      lod2_solid_id,
      lod3_solid_id,
      lod4_solid_id
  )
  SELECT
    array_agg(id),
    array_agg(lod1_multi_surface_id) ||
    array_agg(lod2_multi_surface_id) ||
    array_agg(lod3_multi_surface_id) ||
    array_agg(lod4_multi_surface_id) ||
    array_agg(lod1_solid_id) ||
    array_agg(lod2_solid_id) ||
    array_agg(lod3_solid_id) ||
    array_agg(lod4_solid_id)
  INTO
    deleted_ids,
    surface_geometry_ids
  FROM
    delete_objects;

  -- delete citydb.surface_geometry(s)
  IF -1 = ALL(surface_geometry_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_surface_geometry(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(surface_geometry_ids) AS a_id) a;
  END IF;

  IF $2 <> 1 THEN
    -- delete cityobject
    PERFORM citydb.del_cityobject(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_tunnel(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_tunnel(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_tunnel_furniture(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  implicit_geometry_ids bigint[] := '{}';
  surface_geometry_ids bigint[] := '{}';
BEGIN
  -- delete citydb.tunnel_furnitures
  WITH delete_objects AS (
    DELETE FROM
      citydb.tunnel_furniture t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      lod4_implicit_rep_id,
      lod4_brep_id
  )
  SELECT
    array_agg(id),
    array_agg(lod4_implicit_rep_id),
    array_agg(lod4_brep_id)
  INTO
    deleted_ids,
    implicit_geometry_ids,
    surface_geometry_ids
  FROM
    delete_objects;

  -- delete citydb.implicit_geometry(s)
  IF -1 = ALL(implicit_geometry_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_implicit_geometry(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(implicit_geometry_ids) AS a_id) a
    LEFT JOIN
      citydb.bridge_constr_element n1
      ON n1.lod1_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_constr_element n2
      ON n2.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_constr_element n3
      ON n3.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_constr_element n4
      ON n4.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_furniture n5
      ON n5.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_installation n6
      ON n6.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_installation n7
      ON n7.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_installation n8
      ON n8.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_opening n9
      ON n9.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_opening n10
      ON n10.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.building_furniture n11
      ON n11.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.building_installation n12
      ON n12.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.building_installation n13
      ON n13.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.building_installation n14
      ON n14.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.city_furniture n15
      ON n15.lod1_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.city_furniture n16
      ON n16.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.city_furniture n17
      ON n17.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.city_furniture n18
      ON n18.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n19
      ON n19.lod0_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n20
      ON n20.lod1_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n21
      ON n21.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n22
      ON n22.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n23
      ON n23.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.opening n24
      ON n24.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.opening n25
      ON n25.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.solitary_vegetat_object n26
      ON n26.lod1_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.solitary_vegetat_object n27
      ON n27.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.solitary_vegetat_object n28
      ON n28.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.solitary_vegetat_object n29
      ON n29.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_furniture n30
      ON n30.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_installation n31
      ON n31.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_installation n32
      ON n32.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_installation n33
      ON n33.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_opening n34
      ON n34.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_opening n35
      ON n35.lod4_implicit_rep_id  = a.a_id
    WHERE n1.lod1_implicit_rep_id IS NULL
      AND n2.lod2_implicit_rep_id IS NULL
      AND n3.lod3_implicit_rep_id IS NULL
      AND n4.lod4_implicit_rep_id IS NULL
      AND n5.lod4_implicit_rep_id IS NULL
      AND n6.lod2_implicit_rep_id IS NULL
      AND n7.lod3_implicit_rep_id IS NULL
      AND n8.lod4_implicit_rep_id IS NULL
      AND n9.lod3_implicit_rep_id IS NULL
      AND n10.lod4_implicit_rep_id IS NULL
      AND n11.lod4_implicit_rep_id IS NULL
      AND n12.lod2_implicit_rep_id IS NULL
      AND n13.lod3_implicit_rep_id IS NULL
      AND n14.lod4_implicit_rep_id IS NULL
      AND n15.lod1_implicit_rep_id IS NULL
      AND n16.lod2_implicit_rep_id IS NULL
      AND n17.lod3_implicit_rep_id IS NULL
      AND n18.lod4_implicit_rep_id IS NULL
      AND n19.lod0_implicit_rep_id IS NULL
      AND n20.lod1_implicit_rep_id IS NULL
      AND n21.lod2_implicit_rep_id IS NULL
      AND n22.lod3_implicit_rep_id IS NULL
      AND n23.lod4_implicit_rep_id IS NULL
      AND n24.lod3_implicit_rep_id IS NULL
      AND n25.lod4_implicit_rep_id IS NULL
      AND n26.lod1_implicit_rep_id IS NULL
      AND n27.lod2_implicit_rep_id IS NULL
      AND n28.lod3_implicit_rep_id IS NULL
      AND n29.lod4_implicit_rep_id IS NULL
      AND n30.lod4_implicit_rep_id IS NULL
      AND n31.lod2_implicit_rep_id IS NULL
      AND n32.lod3_implicit_rep_id IS NULL
      AND n33.lod4_implicit_rep_id IS NULL
      AND n34.lod3_implicit_rep_id IS NULL
      AND n35.lod4_implicit_rep_id IS NULL;
  END IF;

  -- delete citydb.surface_geometry(s)
  IF -1 = ALL(surface_geometry_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_surface_geometry(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(surface_geometry_ids) AS a_id) a;
  END IF;

  IF $2 <> 1 THEN
    -- delete cityobject
    PERFORM citydb.del_cityobject(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_tunnel_furniture(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_tunnel_furniture(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_tunnel_hollow_space(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  surface_geometry_ids bigint[] := '{}';
BEGIN
  --delete tunnel_furnitures
  PERFORM
    citydb.del_tunnel_furniture(array_agg(t.id))
  FROM
    citydb.tunnel_furniture t,
    unnest($1) a(a_id)
  WHERE
    t.tunnel_hollow_space_id = a.a_id;

  --delete tunnel_installations
  PERFORM
    citydb.del_tunnel_installation(array_agg(t.id))
  FROM
    citydb.tunnel_installation t,
    unnest($1) a(a_id)
  WHERE
    t.tunnel_hollow_space_id = a.a_id;

  --delete tunnel_thematic_surfaces
  PERFORM
    citydb.del_tunnel_thematic_surface(array_agg(t.id))
  FROM
    citydb.tunnel_thematic_surface t,
    unnest($1) a(a_id)
  WHERE
    t.tunnel_hollow_space_id = a.a_id;

  -- delete citydb.tunnel_hollow_spaces
  WITH delete_objects AS (
    DELETE FROM
      citydb.tunnel_hollow_space t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      lod4_multi_surface_id,
      lod4_solid_id
  )
  SELECT
    array_agg(id),
    array_agg(lod4_multi_surface_id) ||
    array_agg(lod4_solid_id)
  INTO
    deleted_ids,
    surface_geometry_ids
  FROM
    delete_objects;

  -- delete citydb.surface_geometry(s)
  IF -1 = ALL(surface_geometry_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_surface_geometry(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(surface_geometry_ids) AS a_id) a;
  END IF;

  IF $2 <> 1 THEN
    -- delete cityobject
    PERFORM citydb.del_cityobject(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_tunnel_hollow_space(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_tunnel_hollow_space(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_tunnel_installation(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  implicit_geometry_ids bigint[] := '{}';
  surface_geometry_ids bigint[] := '{}';
BEGIN
  --delete tunnel_thematic_surfaces
  PERFORM
    citydb.del_tunnel_thematic_surface(array_agg(t.id))
  FROM
    citydb.tunnel_thematic_surface t,
    unnest($1) a(a_id)
  WHERE
    t.tunnel_installation_id = a.a_id;

  -- delete citydb.tunnel_installations
  WITH delete_objects AS (
    DELETE FROM
      citydb.tunnel_installation t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      lod2_implicit_rep_id,
      lod3_implicit_rep_id,
      lod4_implicit_rep_id,
      lod2_brep_id,
      lod3_brep_id,
      lod4_brep_id
  )
  SELECT
    array_agg(id),
    array_agg(lod2_implicit_rep_id) ||
    array_agg(lod3_implicit_rep_id) ||
    array_agg(lod4_implicit_rep_id),
    array_agg(lod2_brep_id) ||
    array_agg(lod3_brep_id) ||
    array_agg(lod4_brep_id)
  INTO
    deleted_ids,
    implicit_geometry_ids,
    surface_geometry_ids
  FROM
    delete_objects;

  -- delete citydb.implicit_geometry(s)
  IF -1 = ALL(implicit_geometry_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_implicit_geometry(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(implicit_geometry_ids) AS a_id) a
    LEFT JOIN
      citydb.bridge_constr_element n1
      ON n1.lod1_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_constr_element n2
      ON n2.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_constr_element n3
      ON n3.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_constr_element n4
      ON n4.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_furniture n5
      ON n5.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_installation n6
      ON n6.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_installation n7
      ON n7.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_installation n8
      ON n8.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_opening n9
      ON n9.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_opening n10
      ON n10.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.building_furniture n11
      ON n11.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.building_installation n12
      ON n12.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.building_installation n13
      ON n13.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.building_installation n14
      ON n14.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.city_furniture n15
      ON n15.lod1_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.city_furniture n16
      ON n16.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.city_furniture n17
      ON n17.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.city_furniture n18
      ON n18.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n19
      ON n19.lod0_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n20
      ON n20.lod1_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n21
      ON n21.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n22
      ON n22.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n23
      ON n23.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.opening n24
      ON n24.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.opening n25
      ON n25.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.solitary_vegetat_object n26
      ON n26.lod1_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.solitary_vegetat_object n27
      ON n27.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.solitary_vegetat_object n28
      ON n28.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.solitary_vegetat_object n29
      ON n29.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_furniture n30
      ON n30.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_installation n31
      ON n31.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_installation n32
      ON n32.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_installation n33
      ON n33.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_opening n34
      ON n34.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_opening n35
      ON n35.lod4_implicit_rep_id  = a.a_id
    WHERE n1.lod1_implicit_rep_id IS NULL
      AND n2.lod2_implicit_rep_id IS NULL
      AND n3.lod3_implicit_rep_id IS NULL
      AND n4.lod4_implicit_rep_id IS NULL
      AND n5.lod4_implicit_rep_id IS NULL
      AND n6.lod2_implicit_rep_id IS NULL
      AND n7.lod3_implicit_rep_id IS NULL
      AND n8.lod4_implicit_rep_id IS NULL
      AND n9.lod3_implicit_rep_id IS NULL
      AND n10.lod4_implicit_rep_id IS NULL
      AND n11.lod4_implicit_rep_id IS NULL
      AND n12.lod2_implicit_rep_id IS NULL
      AND n13.lod3_implicit_rep_id IS NULL
      AND n14.lod4_implicit_rep_id IS NULL
      AND n15.lod1_implicit_rep_id IS NULL
      AND n16.lod2_implicit_rep_id IS NULL
      AND n17.lod3_implicit_rep_id IS NULL
      AND n18.lod4_implicit_rep_id IS NULL
      AND n19.lod0_implicit_rep_id IS NULL
      AND n20.lod1_implicit_rep_id IS NULL
      AND n21.lod2_implicit_rep_id IS NULL
      AND n22.lod3_implicit_rep_id IS NULL
      AND n23.lod4_implicit_rep_id IS NULL
      AND n24.lod3_implicit_rep_id IS NULL
      AND n25.lod4_implicit_rep_id IS NULL
      AND n26.lod1_implicit_rep_id IS NULL
      AND n27.lod2_implicit_rep_id IS NULL
      AND n28.lod3_implicit_rep_id IS NULL
      AND n29.lod4_implicit_rep_id IS NULL
      AND n30.lod4_implicit_rep_id IS NULL
      AND n31.lod2_implicit_rep_id IS NULL
      AND n32.lod3_implicit_rep_id IS NULL
      AND n33.lod4_implicit_rep_id IS NULL
      AND n34.lod3_implicit_rep_id IS NULL
      AND n35.lod4_implicit_rep_id IS NULL;
  END IF;

  -- delete citydb.surface_geometry(s)
  IF -1 = ALL(surface_geometry_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_surface_geometry(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(surface_geometry_ids) AS a_id) a;
  END IF;

  IF $2 <> 1 THEN
    -- delete cityobject
    PERFORM citydb.del_cityobject(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_tunnel_installation(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_tunnel_installation(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_tunnel_opening(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  implicit_geometry_ids bigint[] := '{}';
  surface_geometry_ids bigint[] := '{}';
BEGIN
  -- delete citydb.tunnel_openings
  WITH delete_objects AS (
    DELETE FROM
      citydb.tunnel_opening t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      lod3_implicit_rep_id,
      lod4_implicit_rep_id,
      lod3_multi_surface_id,
      lod4_multi_surface_id
  )
  SELECT
    array_agg(id),
    array_agg(lod3_implicit_rep_id) ||
    array_agg(lod4_implicit_rep_id),
    array_agg(lod3_multi_surface_id) ||
    array_agg(lod4_multi_surface_id)
  INTO
    deleted_ids,
    implicit_geometry_ids,
    surface_geometry_ids
  FROM
    delete_objects;

  -- delete citydb.implicit_geometry(s)
  IF -1 = ALL(implicit_geometry_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_implicit_geometry(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(implicit_geometry_ids) AS a_id) a
    LEFT JOIN
      citydb.bridge_constr_element n1
      ON n1.lod1_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_constr_element n2
      ON n2.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_constr_element n3
      ON n3.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_constr_element n4
      ON n4.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_furniture n5
      ON n5.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_installation n6
      ON n6.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_installation n7
      ON n7.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_installation n8
      ON n8.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_opening n9
      ON n9.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.bridge_opening n10
      ON n10.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.building_furniture n11
      ON n11.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.building_installation n12
      ON n12.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.building_installation n13
      ON n13.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.building_installation n14
      ON n14.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.city_furniture n15
      ON n15.lod1_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.city_furniture n16
      ON n16.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.city_furniture n17
      ON n17.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.city_furniture n18
      ON n18.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n19
      ON n19.lod0_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n20
      ON n20.lod1_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n21
      ON n21.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n22
      ON n22.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.generic_cityobject n23
      ON n23.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.opening n24
      ON n24.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.opening n25
      ON n25.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.solitary_vegetat_object n26
      ON n26.lod1_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.solitary_vegetat_object n27
      ON n27.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.solitary_vegetat_object n28
      ON n28.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.solitary_vegetat_object n29
      ON n29.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_furniture n30
      ON n30.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_installation n31
      ON n31.lod2_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_installation n32
      ON n32.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_installation n33
      ON n33.lod4_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_opening n34
      ON n34.lod3_implicit_rep_id  = a.a_id
    LEFT JOIN
      citydb.tunnel_opening n35
      ON n35.lod4_implicit_rep_id  = a.a_id
    WHERE n1.lod1_implicit_rep_id IS NULL
      AND n2.lod2_implicit_rep_id IS NULL
      AND n3.lod3_implicit_rep_id IS NULL
      AND n4.lod4_implicit_rep_id IS NULL
      AND n5.lod4_implicit_rep_id IS NULL
      AND n6.lod2_implicit_rep_id IS NULL
      AND n7.lod3_implicit_rep_id IS NULL
      AND n8.lod4_implicit_rep_id IS NULL
      AND n9.lod3_implicit_rep_id IS NULL
      AND n10.lod4_implicit_rep_id IS NULL
      AND n11.lod4_implicit_rep_id IS NULL
      AND n12.lod2_implicit_rep_id IS NULL
      AND n13.lod3_implicit_rep_id IS NULL
      AND n14.lod4_implicit_rep_id IS NULL
      AND n15.lod1_implicit_rep_id IS NULL
      AND n16.lod2_implicit_rep_id IS NULL
      AND n17.lod3_implicit_rep_id IS NULL
      AND n18.lod4_implicit_rep_id IS NULL
      AND n19.lod0_implicit_rep_id IS NULL
      AND n20.lod1_implicit_rep_id IS NULL
      AND n21.lod2_implicit_rep_id IS NULL
      AND n22.lod3_implicit_rep_id IS NULL
      AND n23.lod4_implicit_rep_id IS NULL
      AND n24.lod3_implicit_rep_id IS NULL
      AND n25.lod4_implicit_rep_id IS NULL
      AND n26.lod1_implicit_rep_id IS NULL
      AND n27.lod2_implicit_rep_id IS NULL
      AND n28.lod3_implicit_rep_id IS NULL
      AND n29.lod4_implicit_rep_id IS NULL
      AND n30.lod4_implicit_rep_id IS NULL
      AND n31.lod2_implicit_rep_id IS NULL
      AND n32.lod3_implicit_rep_id IS NULL
      AND n33.lod4_implicit_rep_id IS NULL
      AND n34.lod3_implicit_rep_id IS NULL
      AND n35.lod4_implicit_rep_id IS NULL;
  END IF;

  -- delete citydb.surface_geometry(s)
  IF -1 = ALL(surface_geometry_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_surface_geometry(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(surface_geometry_ids) AS a_id) a;
  END IF;

  IF $2 <> 1 THEN
    -- delete cityobject
    PERFORM citydb.del_cityobject(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_tunnel_opening(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_tunnel_opening(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_tunnel_thematic_surface(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  tunnel_opening_ids bigint[] := '{}';
  surface_geometry_ids bigint[] := '{}';
BEGIN
  -- delete references to tunnel_openings
  WITH del_tunnel_opening_refs AS (
    DELETE FROM
      citydb.tunnel_open_to_them_srf t
    USING
      unnest($1) a(a_id)
    WHERE
      t.tunnel_thematic_surface_id = a.a_id
    RETURNING
      t.tunnel_opening_id
  )
  SELECT
    array_agg(tunnel_opening_id)
  INTO
    tunnel_opening_ids
  FROM
    del_tunnel_opening_refs;

  -- delete citydb.tunnel_opening(s)
  IF -1 = ALL(tunnel_opening_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_tunnel_opening(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(tunnel_opening_ids) AS a_id) a;
  END IF;

  -- delete citydb.tunnel_thematic_surfaces
  WITH delete_objects AS (
    DELETE FROM
      citydb.tunnel_thematic_surface t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      lod2_multi_surface_id,
      lod3_multi_surface_id,
      lod4_multi_surface_id
  )
  SELECT
    array_agg(id),
    array_agg(lod2_multi_surface_id) ||
    array_agg(lod3_multi_surface_id) ||
    array_agg(lod4_multi_surface_id)
  INTO
    deleted_ids,
    surface_geometry_ids
  FROM
    delete_objects;

  -- delete citydb.surface_geometry(s)
  IF -1 = ALL(surface_geometry_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_surface_geometry(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(surface_geometry_ids) AS a_id) a;
  END IF;

  IF $2 <> 1 THEN
    -- delete cityobject
    PERFORM citydb.del_cityobject(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_tunnel_thematic_surface(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_tunnel_thematic_surface(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_abstractdistrictplan(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  IF $2 <> 2 THEN
    FOR rec IN
      SELECT
        co.id, co.objectclass_id
      FROM
        citydb.cityobject co, unnest($1) a(a_id)
      WHERE
        co.id = a.a_id
    LOOP
      object_id := rec.id::bigint;
      objectclass_id := rec.objectclass_id::integer;
      CASE
        -- delete ur_districtplan
        WHEN objectclass_id = 60371 THEN
          dummy_id := citydb.del_ur_districtplan(array_agg(object_id), 1);
        -- delete ur_disasterpreventionbl_2
        WHEN objectclass_id = 60372 THEN
          dummy_id := citydb.del_ur_disasterpreventionbl_2(array_agg(object_id), 1);
        -- delete ur_historicscenerymainten
        WHEN objectclass_id = 60373 THEN
          dummy_id := citydb.del_ur_historicscenerymainten(array_agg(object_id), 1);
        -- delete ur_roadsidedistrictplan
        WHEN objectclass_id = 60374 THEN
          dummy_id := citydb.del_ur_roadsidedistrictplan(array_agg(object_id), 1);
        ELSE
          dummy_id := NULL;
      END CASE;

      IF dummy_id = object_id THEN
        deleted_child_ids := array_append(deleted_child_ids, dummy_id);
      END IF;
    END LOOP;
  END IF;

  -- delete citydb.ur_abstractdistrictplans
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_abstractdistrictplan t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_zone
    PERFORM citydb.del_ur_zone(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_abstractdistrictplan(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_abstractdistrictplan(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_administration(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_dmattribute_ids bigint[] := '{}';
BEGIN
  -- delete references to ur_dmattributes
  WITH del_ur_dmattribute_refs AS (
    DELETE FROM
      citydb.ur_administr_to_dmattribu t
    USING
      unnest($1) a(a_id)
    WHERE
      t.administration_id = a.a_id
    RETURNING
      t.dmattribute_id
  )
  SELECT
    array_agg(dmattribute_id)
  INTO
    ur_dmattribute_ids
  FROM
    del_ur_dmattribute_refs;

  -- delete citydb.ur_dmattribute(s)
  IF -1 = ALL(ur_dmattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_dmattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_dmattribute_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_administrations
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_administration t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_urbanfunction
    PERFORM citydb.del_ur_urbanfunction(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_administration(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_administration(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_agency(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_agencys
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_agency t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_publictransit
    PERFORM citydb.del_ur_publictransit(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_agency(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_agency(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_agreement(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_agreements
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_agreement t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_zone
    PERFORM citydb.del_ur_zone(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_agreement(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_agreement(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_agriculturaldevelopmen(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_agriculturaldevelopmens
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_agriculturaldevelopmen t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_agriculturaldevelopmen(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_agriculturaldevelopmen(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_areaclassification(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_areaclassifications
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_areaclassification t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_zone
    PERFORM citydb.del_ur_zone(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_areaclassification(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_areaclassification(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_areaofannualdiversions(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_areaofannualdiversionss
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_areaofannualdiversions t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_areaofannualdiversions(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_areaofannualdiversions(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_attribution(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_attributions
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_attribution t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_publictransit
    PERFORM citydb.del_ur_publictransit(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_attribution(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_attribution(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_boundary(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_boundarys
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_boundary t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_boundary(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_boundary(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_boundarysurface(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  surface_geometry_ids bigint[] := '{}';
BEGIN
  -- delete citydb.ur_boundarysurfaces
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_boundarysurface t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      lod2multisurface_id,
      lod3multisurface_id
  )
  SELECT
    array_agg(id),
    array_agg(lod2multisurface_id) ||
    array_agg(lod3multisurface_id)
  INTO
    deleted_ids,
    surface_geometry_ids
  FROM
    delete_objects;

  -- delete citydb.surface_geometry(s)
  IF -1 = ALL(surface_geometry_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_surface_geometry(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(surface_geometry_ids) AS a_id) a;
  END IF;

  IF $2 <> 1 THEN
    -- delete cityobject
    PERFORM citydb.del_cityobject(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_boundarysurface(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_boundarysurface(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_breakdownofnominalarea(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_breakdownofnominalareas
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_breakdownofnominalarea t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_breakdownofnominalarea(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_breakdownofnominalarea(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_bridge(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_disasterriskattribute_ids bigint[] := '{}';
  ur_dmattribute_ids bigint[] := '{}';
  ur_facilityattribute_ids bigint[] := '{}';
  ur_keyvaluepairattribute_ids bigint[] := '{}';
  ur_bridgefunctionalattrib_ids bigint[] := '{}';
  ur_bridgestructureattribu_ids bigint[] := '{}';
  ur_constructionbaseattrib_ids bigint[] := '{}';
  ur_constructionriskassess_ids bigint[] := '{}';
  ur_dataqualityattribute_ids bigint[] := '{}';
  ur_facilityidattribute_ids bigint[] := '{}';
  ur_facilitytypeattribute_ids bigint[] := '{}';
BEGIN
  -- delete references to ur_disasterriskattributes
  WITH del_ur_disasterriskattribute_refs AS (
    DELETE FROM
      citydb.ur_bridge_to_disasterr t
    USING
      unnest($1) a(a_id)
    WHERE
      t.bridge_id = a.a_id
    RETURNING
      t.disasterriskattribute_id
  )
  SELECT
    array_agg(disasterriskattribute_id)
  INTO
    ur_disasterriskattribute_ids
  FROM
    del_ur_disasterriskattribute_refs;

  -- delete citydb.ur_disasterriskattribute(s)
  IF -1 = ALL(ur_disasterriskattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_disasterriskattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_disasterriskattribute_ids) AS a_id) a;
  END IF;

  -- delete references to ur_dmattributes
  WITH del_ur_dmattribute_refs AS (
    DELETE FROM
      citydb.ur_bridge_to_dmattribu t
    USING
      unnest($1) a(a_id)
    WHERE
      t.bridge_id = a.a_id
    RETURNING
      t.dmattribute_id
  )
  SELECT
    array_agg(dmattribute_id)
  INTO
    ur_dmattribute_ids
  FROM
    del_ur_dmattribute_refs;

  -- delete citydb.ur_dmattribute(s)
  IF -1 = ALL(ur_dmattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_dmattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_dmattribute_ids) AS a_id) a;
  END IF;

  -- delete references to ur_facilityattributes
  WITH del_ur_facilityattribute_refs AS (
    DELETE FROM
      citydb.ur_bridge_to_facilitya t
    USING
      unnest($1) a(a_id)
    WHERE
      t.bridge_id = a.a_id
    RETURNING
      t.facilityattribute_id
  )
  SELECT
    array_agg(facilityattribute_id)
  INTO
    ur_facilityattribute_ids
  FROM
    del_ur_facilityattribute_refs;

  -- delete citydb.ur_facilityattribute(s)
  IF -1 = ALL(ur_facilityattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_facilityattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_facilityattribute_ids) AS a_id) a;
  END IF;

  -- delete references to ur_keyvaluepairattributes
  WITH del_ur_keyvaluepairattribute_refs AS (
    DELETE FROM
      citydb.ur_bridge_to_keyvaluep t
    USING
      unnest($1) a(a_id)
    WHERE
      t.bridge_id = a.a_id
    RETURNING
      t.keyvaluepairattribute_id
  )
  SELECT
    array_agg(keyvaluepairattribute_id)
  INTO
    ur_keyvaluepairattribute_ids
  FROM
    del_ur_keyvaluepairattribute_refs;

  -- delete citydb.ur_keyvaluepairattribute(s)
  IF -1 = ALL(ur_keyvaluepairattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_keyvaluepairattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_keyvaluepairattribute_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_bridges
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_bridge t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      bridfunctionalattribute_id,
      bridstructureattribute_id,
      bridbaseattribute_id,
      bridriskassessmentattribu_id,
      briddataqualityattribute_id,
      bridfacilityidattribute_id,
      bridfacilitytypeattribute_id
  )
  SELECT
    array_agg(id),
    array_agg(bridfunctionalattribute_id),
    array_agg(bridstructureattribute_id),
    array_agg(bridbaseattribute_id),
    array_agg(bridriskassessmentattribu_id),
    array_agg(briddataqualityattribute_id),
    array_agg(bridfacilityidattribute_id),
    array_agg(bridfacilitytypeattribute_id)
  INTO
    deleted_ids,
    ur_bridgefunctionalattrib_ids,
    ur_bridgestructureattribu_ids,
    ur_constructionbaseattrib_ids,
    ur_constructionriskassess_ids,
    ur_dataqualityattribute_ids,
    ur_facilityidattribute_ids,
    ur_facilitytypeattribute_ids
  FROM
    delete_objects;

  -- delete citydb.ur_bridgefunctionalattrib(s)
  IF -1 = ALL(ur_bridgefunctionalattrib_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_bridgefunctionalattrib(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_bridgefunctionalattrib_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_bridgestructureattribu(s)
  IF -1 = ALL(ur_bridgestructureattribu_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_bridgestructureattribu(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_bridgestructureattribu_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_constructionbaseattrib(s)
  IF -1 = ALL(ur_constructionbaseattrib_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_constructionbaseattrib(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_constructionbaseattrib_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_constructionriskassess(s)
  IF -1 = ALL(ur_constructionriskassess_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_constructionriskassess(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_constructionriskassess_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_dataqualityattribute(s)
  IF -1 = ALL(ur_dataqualityattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_dataqualityattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_dataqualityattribute_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_facilityidattribute(s)
  IF -1 = ALL(ur_facilityidattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_facilityidattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_facilityidattribute_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_facilitytypeattribute(s)
  IF -1 = ALL(ur_facilitytypeattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_facilitytypeattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_facilitytypeattribute_ids) AS a_id) a;
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_bridge(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_bridge(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_bridgefunctionalattrib(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_bridgefunctionalattribs
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_bridgefunctionalattrib t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_bridgefunctionalattrib(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_bridgefunctionalattrib(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_bridgestructureattribu(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_bridgestructureattribus
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_bridgestructureattribu t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_bridgestructureattribu(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_bridgestructureattribu(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_building(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_disasterriskattribute_ids bigint[] := '{}';
  ur_dmattribute_ids bigint[] := '{}';
  ur_facilityattribute_ids bigint[] := '{}';
  ur_keyvaluepairattribute_ids bigint[] := '{}';
  ur_buildingdetailattribut_ids bigint[] := '{}';
  ur_buildingidattribute_ids bigint[] := '{}';
  ur_buildingusecaseattribu_ids bigint[] := '{}';
  ur_dataqualityattribute_ids bigint[] := '{}';
  ur_facilityidattribute_ids bigint[] := '{}';
  ur_facilitytypeattribute_ids bigint[] := '{}';
  ur_ifcattribute_ids bigint[] := '{}';
  ur_indoorattribute_ids bigint[] := '{}';
  ur_largecustomerfacilitya_ids bigint[] := '{}';
  ur_realestateidattribute_ids bigint[] := '{}';
BEGIN
  -- delete references to ur_disasterriskattributes
  WITH del_ur_disasterriskattribute_refs AS (
    DELETE FROM
      citydb.ur_building_to_disasterr t
    USING
      unnest($1) a(a_id)
    WHERE
      t.building_id = a.a_id
    RETURNING
      t.disasterriskattribute_id
  )
  SELECT
    array_agg(disasterriskattribute_id)
  INTO
    ur_disasterriskattribute_ids
  FROM
    del_ur_disasterriskattribute_refs;

  -- delete citydb.ur_disasterriskattribute(s)
  IF -1 = ALL(ur_disasterriskattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_disasterriskattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_disasterriskattribute_ids) AS a_id) a;
  END IF;

  -- delete references to ur_dmattributes
  WITH del_ur_dmattribute_refs AS (
    DELETE FROM
      citydb.ur_building_to_dmattribu t
    USING
      unnest($1) a(a_id)
    WHERE
      t.building_id = a.a_id
    RETURNING
      t.dmattribute_id
  )
  SELECT
    array_agg(dmattribute_id)
  INTO
    ur_dmattribute_ids
  FROM
    del_ur_dmattribute_refs;

  -- delete citydb.ur_dmattribute(s)
  IF -1 = ALL(ur_dmattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_dmattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_dmattribute_ids) AS a_id) a;
  END IF;

  -- delete references to ur_facilityattributes
  WITH del_ur_facilityattribute_refs AS (
    DELETE FROM
      citydb.ur_building_to_facilitya t
    USING
      unnest($1) a(a_id)
    WHERE
      t.building_id = a.a_id
    RETURNING
      t.facilityattribute_id
  )
  SELECT
    array_agg(facilityattribute_id)
  INTO
    ur_facilityattribute_ids
  FROM
    del_ur_facilityattribute_refs;

  -- delete citydb.ur_facilityattribute(s)
  IF -1 = ALL(ur_facilityattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_facilityattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_facilityattribute_ids) AS a_id) a;
  END IF;

  -- delete references to ur_keyvaluepairattributes
  WITH del_ur_keyvaluepairattribute_refs AS (
    DELETE FROM
      citydb.ur_building_to_keyvaluep t
    USING
      unnest($1) a(a_id)
    WHERE
      t.building_id = a.a_id
    RETURNING
      t.keyvaluepairattribute_id
  )
  SELECT
    array_agg(keyvaluepairattribute_id)
  INTO
    ur_keyvaluepairattribute_ids
  FROM
    del_ur_keyvaluepairattribute_refs;

  -- delete citydb.ur_keyvaluepairattribute(s)
  IF -1 = ALL(ur_keyvaluepairattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_keyvaluepairattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_keyvaluepairattribute_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_buildings
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_building t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      buildingdetailattribute_id,
      buildingidattribute_id,
      bldgusecaseattribute_id,
      bldgdataqualityattribute_id,
      bldgfacilityidattribute_id,
      bldgfacilitytypeattribute_id,
      ifcbuildingattribute_id,
      indoorbuildingattribute_id,
      largecustomerfacilityattr_id,
      bldgrealestateidattribute_id
  )
  SELECT
    array_agg(id),
    array_agg(buildingdetailattribute_id),
    array_agg(buildingidattribute_id),
    array_agg(bldgusecaseattribute_id),
    array_agg(bldgdataqualityattribute_id),
    array_agg(bldgfacilityidattribute_id),
    array_agg(bldgfacilitytypeattribute_id),
    array_agg(ifcbuildingattribute_id),
    array_agg(indoorbuildingattribute_id),
    array_agg(largecustomerfacilityattr_id),
    array_agg(bldgrealestateidattribute_id)
  INTO
    deleted_ids,
    ur_buildingdetailattribut_ids,
    ur_buildingidattribute_ids,
    ur_buildingusecaseattribu_ids,
    ur_dataqualityattribute_ids,
    ur_facilityidattribute_ids,
    ur_facilitytypeattribute_ids,
    ur_ifcattribute_ids,
    ur_indoorattribute_ids,
    ur_largecustomerfacilitya_ids,
    ur_realestateidattribute_ids
  FROM
    delete_objects;

  -- delete citydb.ur_buildingdetailattribut(s)
  IF -1 = ALL(ur_buildingdetailattribut_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_buildingdetailattribut(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_buildingdetailattribut_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_buildingidattribute(s)
  IF -1 = ALL(ur_buildingidattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_buildingidattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_buildingidattribute_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_buildingusecaseattribu(s)
  IF -1 = ALL(ur_buildingusecaseattribu_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_buildingusecaseattribu(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_buildingusecaseattribu_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_dataqualityattribute(s)
  IF -1 = ALL(ur_dataqualityattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_dataqualityattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_dataqualityattribute_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_facilityidattribute(s)
  IF -1 = ALL(ur_facilityidattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_facilityidattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_facilityidattribute_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_facilitytypeattribute(s)
  IF -1 = ALL(ur_facilitytypeattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_facilitytypeattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_facilitytypeattribute_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_ifcattribute(s)
  IF -1 = ALL(ur_ifcattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_ifcattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_ifcattribute_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_indoorattribute(s)
  IF -1 = ALL(ur_indoorattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_indoorattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_indoorattribute_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_largecustomerfacilitya(s)
  IF -1 = ALL(ur_largecustomerfacilitya_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_largecustomerfacilitya(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_largecustomerfacilitya_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_realestateidattribute(s)
  IF -1 = ALL(ur_realestateidattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_realestateidattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_realestateidattribute_ids) AS a_id) a;
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_building(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_building(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_building_furniture(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_ifcattribute_ids bigint[] := '{}';
  ur_indoorattribute_ids bigint[] := '{}';
BEGIN
  -- delete citydb.ur_building_furnitures
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_building_furniture t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      ifcbuildingfurnitureattri_id,
      indoorfurnitureattribute_id
  )
  SELECT
    array_agg(id),
    array_agg(ifcbuildingfurnitureattri_id),
    array_agg(indoorfurnitureattribute_id)
  INTO
    deleted_ids,
    ur_ifcattribute_ids,
    ur_indoorattribute_ids
  FROM
    delete_objects;

  -- delete citydb.ur_ifcattribute(s)
  IF -1 = ALL(ur_ifcattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_ifcattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_ifcattribute_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_indoorattribute(s)
  IF -1 = ALL(ur_indoorattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_indoorattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_indoorattribute_ids) AS a_id) a;
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_building_furniture(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_building_furniture(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_building_installation(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_ifcattribute_ids bigint[] := '{}';
  ur_indoorattribute_ids bigint[] := '{}';
BEGIN
  -- delete citydb.ur_building_installations
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_building_installation t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      ifcbuildinginstallationat_id,
      ifcintbuildinginstallatio_id,
      indoorintinstallationattr_id
  )
  SELECT
    array_agg(id),
    array_agg(ifcbuildinginstallationat_id) ||
    array_agg(ifcintbuildinginstallatio_id),
    array_agg(indoorintinstallationattr_id)
  INTO
    deleted_ids,
    ur_ifcattribute_ids,
    ur_indoorattribute_ids
  FROM
    delete_objects;

  -- delete citydb.ur_ifcattribute(s)
  IF -1 = ALL(ur_ifcattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_ifcattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_ifcattribute_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_indoorattribute(s)
  IF -1 = ALL(ur_indoorattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_indoorattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_indoorattribute_ids) AS a_id) a;
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_building_installation(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_building_installation(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_buildingattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  IF $2 <> 2 THEN
    FOR rec IN
      SELECT
        co.id, co.objectclass_id
      FROM
        citydb.cityobject co, unnest($1) a(a_id)
      WHERE
        co.id = a.a_id
    LOOP
      object_id := rec.id::bigint;
      objectclass_id := rec.objectclass_id::integer;
      CASE
        -- delete ur_buildingidattribute
        WHEN objectclass_id = 60027 THEN
          dummy_id := citydb.del_ur_buildingidattribute(array_agg(object_id), 1);
        -- delete ur_buildingdetailattribut
        WHEN objectclass_id = 60028 THEN
          dummy_id := citydb.del_ur_buildingdetailattribut(array_agg(object_id), 1);
        -- delete ur_largecustomerfacilitya
        WHEN objectclass_id = 60029 THEN
          dummy_id := citydb.del_ur_largecustomerfacilitya(array_agg(object_id), 1);
        -- delete ur_realestateidattribute
        WHEN objectclass_id = 60030 THEN
          dummy_id := citydb.del_ur_realestateidattribute(array_agg(object_id), 1);
        -- delete ur_buildingusecaseattribu
        WHEN objectclass_id = 60031 THEN
          dummy_id := citydb.del_ur_buildingusecaseattribu(array_agg(object_id), 1);
        ELSE
          dummy_id := NULL;
      END CASE;

      IF dummy_id = object_id THEN
        deleted_child_ids := array_append(deleted_child_ids, dummy_id);
      END IF;
    END LOOP;
  END IF;

  -- delete citydb.ur_buildingattributes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_buildingattribute t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_buildingattribute(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_buildingattribute(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_buildingdetailattribut(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_buildingdetailattributs
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_buildingdetailattribut t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_buildingattribute
    PERFORM citydb.del_ur_buildingattribute(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_buildingdetailattribut(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_buildingdetailattribut(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_buildingidattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_buildingidattributes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_buildingidattribute t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_buildingattribute
    PERFORM citydb.del_ur_buildingattribute(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_buildingidattribute(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_buildingidattribute(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_buildingusecaseattribu(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_buildingusecaseattribus
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_buildingusecaseattribu t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_buildingattribute
    PERFORM citydb.del_ur_buildingattribute(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_buildingusecaseattribu(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_buildingusecaseattribu(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_cable(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_cables
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_cable t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_utilitylink
    PERFORM citydb.del_ur_utilitylink(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_cable(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_cable(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_calendar(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_calendars
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_calendar t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_publictransit
    PERFORM citydb.del_ur_publictransit(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_calendar(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_calendar(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_calendardate(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_calendardates
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_calendardate t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_publictransit
    PERFORM citydb.del_ur_publictransit(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_calendardate(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_calendardate(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_cargohandlingfacility(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_cargohandlingfacilitys
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_cargohandlingfacility t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_portattribute
    PERFORM citydb.del_ur_portattribute(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_cargohandlingfacility(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_cargohandlingfacility(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_censusblock(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_daytimepopulationtype_ids bigint[] := '{}';
  ur_economicactivitytype_ids bigint[] := '{}';
  ur_populationtype_ids bigint[] := '{}';
BEGIN
  -- delete citydb.ur_censusblocks
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_censusblock t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      daytimepopulationtype_id,
      economicactivitytype_id,
      populationtype_id
  )
  SELECT
    array_agg(id),
    array_agg(daytimepopulationtype_id),
    array_agg(economicactivitytype_id),
    array_agg(populationtype_id)
  INTO
    deleted_ids,
    ur_daytimepopulationtype_ids,
    ur_economicactivitytype_ids,
    ur_populationtype_ids
  FROM
    delete_objects;

  -- delete citydb.ur_daytimepopulationtype(s)
  IF -1 = ALL(ur_daytimepopulationtype_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_daytimepopulationtype(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_daytimepopulationtype_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_economicactivitytype(s)
  IF -1 = ALL(ur_economicactivitytype_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_economicactivitytype(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_economicactivitytype_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_populationtype(s)
  IF -1 = ALL(ur_populationtype_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_populationtype(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_populationtype_ids) AS a_id) a;
  END IF;

  IF $2 <> 1 THEN
    -- delete ur_urbanfunction
    PERFORM citydb.del_ur_urbanfunction(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_censusblock(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_censusblock(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_circularcurvetype(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_circularcurvetypes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_circularcurvetype t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_circularcurvetype(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_circularcurvetype(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_city_furniture(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_dmattribute_ids bigint[] := '{}';
  ur_facilityattribute_ids bigint[] := '{}';
  ur_keyvaluepairattribute_ids bigint[] := '{}';
  ur_cityfurnitureattribute_ids bigint[] := '{}';
  ur_dataqualityattribute_ids bigint[] := '{}';
  ur_facilityidattribute_ids bigint[] := '{}';
  ur_facilitytypeattribute_ids bigint[] := '{}';
BEGIN
  -- delete references to ur_dmattributes
  WITH del_ur_dmattribute_refs AS (
    DELETE FROM
      citydb.ur_city_furn_to_dmattribu t
    USING
      unnest($1) a(a_id)
    WHERE
      t.city_furniture_id = a.a_id
    RETURNING
      t.dmattribute_id
  )
  SELECT
    array_agg(dmattribute_id)
  INTO
    ur_dmattribute_ids
  FROM
    del_ur_dmattribute_refs;

  -- delete citydb.ur_dmattribute(s)
  IF -1 = ALL(ur_dmattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_dmattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_dmattribute_ids) AS a_id) a;
  END IF;

  -- delete references to ur_facilityattributes
  WITH del_ur_facilityattribute_refs AS (
    DELETE FROM
      citydb.ur_city_furn_to_facilitya t
    USING
      unnest($1) a(a_id)
    WHERE
      t.city_furniture_id = a.a_id
    RETURNING
      t.facilityattribute_id
  )
  SELECT
    array_agg(facilityattribute_id)
  INTO
    ur_facilityattribute_ids
  FROM
    del_ur_facilityattribute_refs;

  -- delete citydb.ur_facilityattribute(s)
  IF -1 = ALL(ur_facilityattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_facilityattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_facilityattribute_ids) AS a_id) a;
  END IF;

  -- delete references to ur_keyvaluepairattributes
  WITH del_ur_keyvaluepairattribute_refs AS (
    DELETE FROM
      citydb.ur_city_furn_to_keyvaluep t
    USING
      unnest($1) a(a_id)
    WHERE
      t.city_furniture_id = a.a_id
    RETURNING
      t.keyvaluepairattribute_id
  )
  SELECT
    array_agg(keyvaluepairattribute_id)
  INTO
    ur_keyvaluepairattribute_ids
  FROM
    del_ur_keyvaluepairattribute_refs;

  -- delete citydb.ur_keyvaluepairattribute(s)
  IF -1 = ALL(ur_keyvaluepairattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_keyvaluepairattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_keyvaluepairattribute_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_city_furnitures
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_city_furniture t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      cityfurnituredetailattrib_id,
      frndataqualityattribute_id,
      frnfacilityidattribute_id,
      frnfacilitytypeattribute_id
  )
  SELECT
    array_agg(id),
    array_agg(cityfurnituredetailattrib_id),
    array_agg(frndataqualityattribute_id),
    array_agg(frnfacilityidattribute_id),
    array_agg(frnfacilitytypeattribute_id)
  INTO
    deleted_ids,
    ur_cityfurnitureattribute_ids,
    ur_dataqualityattribute_ids,
    ur_facilityidattribute_ids,
    ur_facilitytypeattribute_ids
  FROM
    delete_objects;

  -- delete citydb.ur_cityfurnitureattribute(s)
  IF -1 = ALL(ur_cityfurnitureattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_cityfurnitureattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_cityfurnitureattribute_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_dataqualityattribute(s)
  IF -1 = ALL(ur_dataqualityattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_dataqualityattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_dataqualityattribute_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_facilityidattribute(s)
  IF -1 = ALL(ur_facilityidattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_facilityidattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_facilityidattribute_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_facilitytypeattribute(s)
  IF -1 = ALL(ur_facilitytypeattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_facilitytypeattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_facilitytypeattribute_ids) AS a_id) a;
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_city_furniture(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_city_furniture(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_cityfurnitureattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_cityfurnitureattributes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_cityfurnitureattribute t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_cityfurnitureattribute(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_cityfurnitureattribute(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_cityobject(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_dmattribute_ids bigint[] := '{}';
  ur_facilityattribute_ids bigint[] := '{}';
  ur_keyvaluepairattribute_ids bigint[] := '{}';
  ur_dataqualityattribute_ids bigint[] := '{}';
  ur_facilityidattribute_ids bigint[] := '{}';
  ur_facilitytypeattribute_ids bigint[] := '{}';
BEGIN
  -- delete references to ur_dmattributes
  WITH del_ur_dmattribute_refs AS (
    DELETE FROM
      citydb.ur_cityobjec_to_dmattribu t
    USING
      unnest($1) a(a_id)
    WHERE
      t.cityobject_id = a.a_id
    RETURNING
      t.dmattribute_id
  )
  SELECT
    array_agg(dmattribute_id)
  INTO
    ur_dmattribute_ids
  FROM
    del_ur_dmattribute_refs;

  -- delete citydb.ur_dmattribute(s)
  IF -1 = ALL(ur_dmattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_dmattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_dmattribute_ids) AS a_id) a;
  END IF;

  -- delete references to ur_facilityattributes
  WITH del_ur_facilityattribute_refs AS (
    DELETE FROM
      citydb.ur_cityobjec_to_facilitya t
    USING
      unnest($1) a(a_id)
    WHERE
      t.cityobject_id = a.a_id
    RETURNING
      t.facilityattribute_id
  )
  SELECT
    array_agg(facilityattribute_id)
  INTO
    ur_facilityattribute_ids
  FROM
    del_ur_facilityattribute_refs;

  -- delete citydb.ur_facilityattribute(s)
  IF -1 = ALL(ur_facilityattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_facilityattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_facilityattribute_ids) AS a_id) a;
  END IF;

  -- delete references to ur_keyvaluepairattributes
  WITH del_ur_keyvaluepairattribute_refs AS (
    DELETE FROM
      citydb.ur_cityobjec_to_keyvaluep t
    USING
      unnest($1) a(a_id)
    WHERE
      t.cityobject_id = a.a_id
    RETURNING
      t.keyvaluepairattribute_id
  )
  SELECT
    array_agg(keyvaluepairattribute_id)
  INTO
    ur_keyvaluepairattribute_ids
  FROM
    del_ur_keyvaluepairattribute_refs;

  -- delete citydb.ur_keyvaluepairattribute(s)
  IF -1 = ALL(ur_keyvaluepairattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_keyvaluepairattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_keyvaluepairattribute_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_cityobjects
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_cityobject t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      vegdataqualityattribute_id,
      vegfacilityidattribute_id,
      vegfacilitytypeattribute_id
  )
  SELECT
    array_agg(id),
    array_agg(vegdataqualityattribute_id),
    array_agg(vegfacilityidattribute_id),
    array_agg(vegfacilitytypeattribute_id)
  INTO
    deleted_ids,
    ur_dataqualityattribute_ids,
    ur_facilityidattribute_ids,
    ur_facilitytypeattribute_ids
  FROM
    delete_objects;

  -- delete citydb.ur_dataqualityattribute(s)
  IF -1 = ALL(ur_dataqualityattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_dataqualityattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_dataqualityattribute_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_facilityidattribute(s)
  IF -1 = ALL(ur_facilityidattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_facilityidattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_facilityidattribute_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_facilitytypeattribute(s)
  IF -1 = ALL(ur_facilitytypeattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_facilitytypeattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_facilitytypeattribute_ids) AS a_id) a;
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_cityobject(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_cityobject(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_cityobjectgroup(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_cityobjectgroups
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_cityobjectgroup t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_cityobjectgroup(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_cityobjectgroup(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_cityobjectgroup_1(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_ifcattribute_ids bigint[] := '{}';
  ur_indoorattribute_ids bigint[] := '{}';
BEGIN
  -- delete citydb.ur_cityobjectgroup_1s
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_cityobjectgroup_1 t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      ifcbuildingstoreyattribut_id,
      indoorstoreyattribute_id
  )
  SELECT
    array_agg(id),
    array_agg(ifcbuildingstoreyattribut_id),
    array_agg(indoorstoreyattribute_id)
  INTO
    deleted_ids,
    ur_ifcattribute_ids,
    ur_indoorattribute_ids
  FROM
    delete_objects;

  -- delete citydb.ur_ifcattribute(s)
  IF -1 = ALL(ur_ifcattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_ifcattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_ifcattribute_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_indoorattribute(s)
  IF -1 = ALL(ur_indoorattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_indoorattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_indoorattribute_ids) AS a_id) a;
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_cityobjectgroup_1(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_cityobjectgroup_1(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_cityobjectgroup_2(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_cityobjectgroup_2s
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_cityobjectgroup_2 t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_cityobjectgroup_2(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_cityobjectgroup_2(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_cityobjectgroup_3(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_publictransitdatatype_ids bigint[] := '{}';
BEGIN
  -- delete references to ur_publictransitdatatypes
  WITH del_ur_publictransitdatatype_refs AS (
    DELETE FROM
      citydb.ur_cityobjec_to_publictra t
    USING
      unnest($1) a(a_id)
    WHERE
      t.cityobjectgroup_3_id = a.a_id
    RETURNING
      t.publictransitdatatype_id
  )
  SELECT
    array_agg(publictransitdatatype_id)
  INTO
    ur_publictransitdatatype_ids
  FROM
    del_ur_publictransitdatatype_refs;

  -- delete citydb.ur_publictransitdatatype(s)
  IF -1 = ALL(ur_publictransitdatatype_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_publictransitdatatype(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_publictransitdatatype_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_cityobjectgroup_3s
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_cityobjectgroup_3 t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_cityobjectgroup_3(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_cityobjectgroup_3(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_collectivefacilities_2(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_collectivefacilities_2s
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_collectivefacilities_2 t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_urbanfacility
    PERFORM citydb.del_ur_urbanfacility(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_collectivefacilities_2(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_collectivefacilities_2(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_collectivefacilities_3(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_collectivefacilities_3s
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_collectivefacilities_3 t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_urbanfacility
    PERFORM citydb.del_ur_urbanfacility(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_collectivefacilities_3(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_collectivefacilities_3(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_collectivefacilitiesfo(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_collectivefacilitiesfos
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_collectivefacilitiesfo t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_urbanfacility
    PERFORM citydb.del_ur_urbanfacility(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_collectivefacilitiesfo(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_collectivefacilitiesfo(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_collectivegovernmentan(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_collectivegovernmentans
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_collectivegovernmentan t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_urbanfacility
    PERFORM citydb.del_ur_urbanfacility(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_collectivegovernmentan(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_collectivegovernmentan(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_collectivehousingfacil(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_collectivehousingfacils
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_collectivehousingfacil t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_urbanfacility
    PERFORM citydb.del_ur_urbanfacility(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_collectivehousingfacil(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_collectivehousingfacil(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_collectiveurbandisaste(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_collectiveurbandisastes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_collectiveurbandisaste t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_urbanfacility
    PERFORM citydb.del_ur_urbanfacility(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_collectiveurbandisaste(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_collectiveurbandisaste(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_construction(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_constructionevent_ids bigint[] := '{}';
  ur_disasterriskattribute_ids bigint[] := '{}';
  ur_dmattribute_ids bigint[] := '{}';
  ur_elevation_ids bigint[] := '{}';
  ur_facilityattribute_ids bigint[] := '{}';
  ur_facilitytypeattribute_ids bigint[] := '{}';
  ur_height_ids bigint[] := '{}';
  ur_keyvaluepairattribute_ids bigint[] := '{}';
  ur_occupancy_ids bigint[] := '{}';
  surface_geometry_ids bigint[] := '{}';
  ur_constructionbaseattrib_ids bigint[] := '{}';
  ur_constructionstructurea_ids bigint[] := '{}';
  ur_dataqualityattribute_ids bigint[] := '{}';
  ur_facilityidattribute_ids bigint[] := '{}';
BEGIN
  -- delete references to ur_constructionevents
  WITH del_ur_constructionevent_refs AS (
    DELETE FROM
      citydb.ur_construct_to_construct t
    USING
      unnest($1) a(a_id)
    WHERE
      t.construction_id = a.a_id
    RETURNING
      t.constructionevent_id
  )
  SELECT
    array_agg(constructionevent_id)
  INTO
    ur_constructionevent_ids
  FROM
    del_ur_constructionevent_refs;

  -- delete citydb.ur_constructionevent(s)
  IF -1 = ALL(ur_constructionevent_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_constructionevent(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_constructionevent_ids) AS a_id) a;
  END IF;

  -- delete references to ur_disasterriskattributes
  WITH del_ur_disasterriskattribute_refs AS (
    DELETE FROM
      citydb.ur_construct_to_disasterr t
    USING
      unnest($1) a(a_id)
    WHERE
      t.construction_id = a.a_id
    RETURNING
      t.disasterriskattribute_id
  )
  SELECT
    array_agg(disasterriskattribute_id)
  INTO
    ur_disasterriskattribute_ids
  FROM
    del_ur_disasterriskattribute_refs;

  -- delete citydb.ur_disasterriskattribute(s)
  IF -1 = ALL(ur_disasterriskattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_disasterriskattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_disasterriskattribute_ids) AS a_id) a;
  END IF;

  -- delete references to ur_dmattributes
  WITH del_ur_dmattribute_refs AS (
    DELETE FROM
      citydb.ur_construct_to_dmattribu t
    USING
      unnest($1) a(a_id)
    WHERE
      t.construction_id = a.a_id
    RETURNING
      t.dmattribute_id
  )
  SELECT
    array_agg(dmattribute_id)
  INTO
    ur_dmattribute_ids
  FROM
    del_ur_dmattribute_refs;

  -- delete citydb.ur_dmattribute(s)
  IF -1 = ALL(ur_dmattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_dmattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_dmattribute_ids) AS a_id) a;
  END IF;

  -- delete references to ur_elevations
  WITH del_ur_elevation_refs AS (
    DELETE FROM
      citydb.ur_construct_to_elevation t
    USING
      unnest($1) a(a_id)
    WHERE
      t.construction_id = a.a_id
    RETURNING
      t.elevation_id
  )
  SELECT
    array_agg(elevation_id)
  INTO
    ur_elevation_ids
  FROM
    del_ur_elevation_refs;

  -- delete citydb.ur_elevation(s)
  IF -1 = ALL(ur_elevation_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_elevation(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_elevation_ids) AS a_id) a;
  END IF;

  -- delete references to ur_facilityattributes
  WITH del_ur_facilityattribute_refs AS (
    DELETE FROM
      citydb.ur_construct_to_facilitya t
    USING
      unnest($1) a(a_id)
    WHERE
      t.construction_id = a.a_id
    RETURNING
      t.facilityattribute_id
  )
  SELECT
    array_agg(facilityattribute_id)
  INTO
    ur_facilityattribute_ids
  FROM
    del_ur_facilityattribute_refs;

  -- delete citydb.ur_facilityattribute(s)
  IF -1 = ALL(ur_facilityattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_facilityattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_facilityattribute_ids) AS a_id) a;
  END IF;

  -- delete references to ur_facilitytypeattributes
  WITH del_ur_facilitytypeattribute_refs AS (
    DELETE FROM
      citydb.ur_construct_to_facilityt t
    USING
      unnest($1) a(a_id)
    WHERE
      t.construction_id = a.a_id
    RETURNING
      t.facilitytypeattribute_id
  )
  SELECT
    array_agg(facilitytypeattribute_id)
  INTO
    ur_facilitytypeattribute_ids
  FROM
    del_ur_facilitytypeattribute_refs;

  -- delete citydb.ur_facilitytypeattribute(s)
  IF -1 = ALL(ur_facilitytypeattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_facilitytypeattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_facilitytypeattribute_ids) AS a_id) a;
  END IF;

  -- delete references to ur_heights
  WITH del_ur_height_refs AS (
    DELETE FROM
      citydb.ur_construct_to_height t
    USING
      unnest($1) a(a_id)
    WHERE
      t.construction_id = a.a_id
    RETURNING
      t.height_id
  )
  SELECT
    array_agg(height_id)
  INTO
    ur_height_ids
  FROM
    del_ur_height_refs;

  -- delete citydb.ur_height(s)
  IF -1 = ALL(ur_height_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_height(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_height_ids) AS a_id) a;
  END IF;

  -- delete references to ur_keyvaluepairattributes
  WITH del_ur_keyvaluepairattribute_refs AS (
    DELETE FROM
      citydb.ur_construct_to_keyvaluep t
    USING
      unnest($1) a(a_id)
    WHERE
      t.construction_id = a.a_id
    RETURNING
      t.keyvaluepairattribute_id
  )
  SELECT
    array_agg(keyvaluepairattribute_id)
  INTO
    ur_keyvaluepairattribute_ids
  FROM
    del_ur_keyvaluepairattribute_refs;

  -- delete citydb.ur_keyvaluepairattribute(s)
  IF -1 = ALL(ur_keyvaluepairattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_keyvaluepairattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_keyvaluepairattribute_ids) AS a_id) a;
  END IF;

  -- delete references to ur_occupancys
  WITH del_ur_occupancy_refs AS (
    DELETE FROM
      citydb.ur_construct_to_occupancy t
    USING
      unnest($1) a(a_id)
    WHERE
      t.construction_id = a.a_id
    RETURNING
      t.occupancy_id
  )
  SELECT
    array_agg(occupancy_id)
  INTO
    ur_occupancy_ids
  FROM
    del_ur_occupancy_refs;

  -- delete citydb.ur_occupancy(s)
  IF -1 = ALL(ur_occupancy_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_occupancy(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_occupancy_ids) AS a_id) a;
  END IF;

  IF $2 <> 2 THEN
    FOR rec IN
      SELECT
        co.id, co.objectclass_id
      FROM
        citydb.cityobject co, unnest($1) a(a_id)
      WHERE
        co.id = a.a_id
    LOOP
      object_id := rec.id::bigint;
      objectclass_id := rec.objectclass_id::integer;
      CASE
        -- delete ur_otherconstruction
        WHEN objectclass_id = 60093 THEN
          dummy_id := citydb.del_ur_otherconstruction(array_agg(object_id), 1);
        ELSE
          dummy_id := NULL;
      END CASE;

      IF dummy_id = object_id THEN
        deleted_child_ids := array_append(deleted_child_ids, dummy_id);
      END IF;
    END LOOP;
  END IF;

  -- delete citydb.ur_constructions
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_construction t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      lod0geometry_brep_id,
      lod1geometry_brep_id,
      lod2geometry_brep_id,
      lod3geometry_brep_id,
      lod4geometry_brep_id,
      consbaseattribute_id,
      consstructureattribute_id,
      consdataqualityattribute_id,
      consfacilityidattribute_id
  )
  SELECT
    array_agg(id),
    array_agg(lod0geometry_brep_id) ||
    array_agg(lod1geometry_brep_id) ||
    array_agg(lod2geometry_brep_id) ||
    array_agg(lod3geometry_brep_id) ||
    array_agg(lod4geometry_brep_id),
    array_agg(consbaseattribute_id),
    array_agg(consstructureattribute_id),
    array_agg(consdataqualityattribute_id),
    array_agg(consfacilityidattribute_id)
  INTO
    deleted_ids,
    surface_geometry_ids,
    ur_constructionbaseattrib_ids,
    ur_constructionstructurea_ids,
    ur_dataqualityattribute_ids,
    ur_facilityidattribute_ids
  FROM
    delete_objects;

  -- delete citydb.surface_geometry(s)
  IF -1 = ALL(surface_geometry_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_surface_geometry(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(surface_geometry_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_constructionbaseattrib(s)
  IF -1 = ALL(ur_constructionbaseattrib_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_constructionbaseattrib(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_constructionbaseattrib_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_constructionstructurea(s)
  IF -1 = ALL(ur_constructionstructurea_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_constructionstructurea(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_constructionstructurea_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_dataqualityattribute(s)
  IF -1 = ALL(ur_dataqualityattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_dataqualityattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_dataqualityattribute_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_facilityidattribute(s)
  IF -1 = ALL(ur_facilityidattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_facilityidattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_facilityidattribute_ids) AS a_id) a;
  END IF;

  IF $2 <> 1 THEN
    -- delete cityobject
    PERFORM citydb.del_cityobject(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_construction(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_construction(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_constructionbaseattrib(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_constructionbaseattribs
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_constructionbaseattrib t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_constructionbaseattrib(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_constructionbaseattrib(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_constructionevent(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_constructionevents
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_constructionevent t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_constructionevent(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_constructionevent(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_constructioninstallati(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  surface_geometry_ids bigint[] := '{}';
BEGIN
  -- delete citydb.ur_constructioninstallatis
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_constructioninstallati t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      lod2geometry_brep_id,
      lod3geometry_brep_id
  )
  SELECT
    array_agg(id),
    array_agg(lod2geometry_brep_id) ||
    array_agg(lod3geometry_brep_id)
  INTO
    deleted_ids,
    surface_geometry_ids
  FROM
    delete_objects;

  -- delete citydb.surface_geometry(s)
  IF -1 = ALL(surface_geometry_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_surface_geometry(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(surface_geometry_ids) AS a_id) a;
  END IF;

  IF $2 <> 1 THEN
    -- delete cityobject
    PERFORM citydb.del_cityobject(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_constructioninstallati(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_constructioninstallati(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_constructionriskassess(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_constructionriskassesss
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_constructionriskassess t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_constructionriskassess(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_constructionriskassess(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_constructionstructurea(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  IF $2 <> 2 THEN
    FOR rec IN
      SELECT
        co.id, co.objectclass_id
      FROM
        citydb.cityobject co, unnest($1) a(a_id)
      WHERE
        co.id = a.a_id
    LOOP
      object_id := rec.id::bigint;
      objectclass_id := rec.objectclass_id::integer;
      CASE
        -- delete ur_embankmentattribute
        WHEN objectclass_id = 60082 THEN
          dummy_id := citydb.del_ur_embankmentattribute(array_agg(object_id), 1);
        -- delete ur_damattribute
        WHEN objectclass_id = 60083 THEN
          dummy_id := citydb.del_ur_damattribute(array_agg(object_id), 1);
        ELSE
          dummy_id := NULL;
      END CASE;

      IF dummy_id = object_id THEN
        deleted_child_ids := array_append(deleted_child_ids, dummy_id);
      END IF;
    END LOOP;
  END IF;

  -- delete citydb.ur_constructionstructureas
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_constructionstructurea t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_constructionstructurea(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_constructionstructurea(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_controlpoint(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_controlpointtype_ids bigint[] := '{}';
BEGIN
  -- delete citydb.ur_controlpoints
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_controlpoint t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      parameter_id
  )
  SELECT
    array_agg(id),
    array_agg(parameter_id)
  INTO
    deleted_ids,
    ur_controlpointtype_ids
  FROM
    delete_objects;

  -- delete citydb.ur_controlpointtype(s)
  IF -1 = ALL(ur_controlpointtype_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_controlpointtype(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_controlpointtype_ids) AS a_id) a;
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_controlpoint(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_controlpoint(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_controlpointtype(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_circularcurvetype_ids bigint[] := '{}';
  ur_slopetype_ids bigint[] := '{}';
  ur_transitioncurvetype_ids bigint[] := '{}';
  ur_verticalcurvetype_ids bigint[] := '{}';
BEGIN
  -- delete citydb.ur_controlpointtypes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_controlpointtype t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      circularcurve_id,
      slopetype_id,
      transitioncurve_id,
      verticalcurve_id
  )
  SELECT
    array_agg(id),
    array_agg(circularcurve_id),
    array_agg(slopetype_id),
    array_agg(transitioncurve_id),
    array_agg(verticalcurve_id)
  INTO
    deleted_ids,
    ur_circularcurvetype_ids,
    ur_slopetype_ids,
    ur_transitioncurvetype_ids,
    ur_verticalcurvetype_ids
  FROM
    delete_objects;

  -- delete citydb.ur_circularcurvetype(s)
  IF -1 = ALL(ur_circularcurvetype_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_circularcurvetype(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_circularcurvetype_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_slopetype(s)
  IF -1 = ALL(ur_slopetype_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_slopetype(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_slopetype_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_transitioncurvetype(s)
  IF -1 = ALL(ur_transitioncurvetype_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_transitioncurvetype(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_transitioncurvetype_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_verticalcurvetype(s)
  IF -1 = ALL(ur_verticalcurvetype_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_verticalcurvetype(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_verticalcurvetype_ids) AS a_id) a;
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_controlpointtype(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_controlpointtype(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_countermeasurescost(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_countermeasurescosts
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_countermeasurescost t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_countermeasurescost(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_countermeasurescost(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_crs(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_crss
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_crs t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_crs(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_crs(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_cyberportmarinaandpbs(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_cyberportmarinaandpbss
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_cyberportmarinaandpbs t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_portattribute
    PERFORM citydb.del_ur_portattribute(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_cyberportmarinaandpbs(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_cyberportmarinaandpbs(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_damattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_damattributes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_damattribute t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_constructionstructurea
    PERFORM citydb.del_ur_constructionstructurea(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_damattribute(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_damattribute(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_dataqualityattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_publicsurveydataqualit_ids bigint[] := '{}';
BEGIN
  -- delete citydb.ur_dataqualityattributes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_dataqualityattribute t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      publicsurveydataqualityat_id
  )
  SELECT
    array_agg(id),
    array_agg(publicsurveydataqualityat_id)
  INTO
    deleted_ids,
    ur_publicsurveydataqualit_ids
  FROM
    delete_objects;

  -- delete citydb.ur_publicsurveydataqualit(s)
  IF -1 = ALL(ur_publicsurveydataqualit_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_publicsurveydataqualit(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_publicsurveydataqualit_ids) AS a_id) a;
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_dataqualityattribute(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_dataqualityattribute(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_daytimepopulationtype(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_daytimepopulationtypes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_daytimepopulationtype t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_daytimepopulationtype(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_daytimepopulationtype(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_description(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_descriptions
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_description t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_description(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_description(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_developmentproject(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_agriculturaldevelopmen_ids bigint[] := '{}';
  ur_residentialdevelopment_ids bigint[] := '{}';
  ur_urbandevelopmentprojec_ids bigint[] := '{}';
BEGIN
  -- delete citydb.ur_developmentprojects
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_developmentproject t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      agriculturaldevelopmentty_id,
      residentialdevelopmenttyp_id,
      urbandevelopmenttype_id
  )
  SELECT
    array_agg(id),
    array_agg(agriculturaldevelopmentty_id),
    array_agg(residentialdevelopmenttyp_id),
    array_agg(urbandevelopmenttype_id)
  INTO
    deleted_ids,
    ur_agriculturaldevelopmen_ids,
    ur_residentialdevelopment_ids,
    ur_urbandevelopmentprojec_ids
  FROM
    delete_objects;

  -- delete citydb.ur_agriculturaldevelopmen(s)
  IF -1 = ALL(ur_agriculturaldevelopmen_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_agriculturaldevelopmen(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_agriculturaldevelopmen_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_residentialdevelopment(s)
  IF -1 = ALL(ur_residentialdevelopment_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_residentialdevelopment(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_residentialdevelopment_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_urbandevelopmentprojec(s)
  IF -1 = ALL(ur_urbandevelopmentprojec_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_urbandevelopmentprojec(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_urbandevelopmentprojec_ids) AS a_id) a;
  END IF;

  IF $2 <> 1 THEN
    -- delete ur_urbanfunction
    PERFORM citydb.del_ur_urbanfunction(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_developmentproject(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_developmentproject(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_did(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_dids
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_did t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_urbanfunction
    PERFORM citydb.del_ur_urbanfunction(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_did(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_did(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_disasterdamage(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_disasterdamages
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_disasterdamage t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_urbanfunction
    PERFORM citydb.del_ur_urbanfunction(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_disasterdamage(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_disasterdamage(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_disasterpreventionbase(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_disasterpreventionbases
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_disasterpreventionbase t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_urbanfunction
    PERFORM citydb.del_ur_urbanfunction(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_disasterpreventionbase(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_disasterpreventionbase(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_disasterpreventionbl_2(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_disasterpreventionbl_2s
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_disasterpreventionbl_2 t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_abstractdistrictplan
    PERFORM citydb.del_ur_abstractdistrictplan(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_disasterpreventionbl_2(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_disasterpreventionbl_2(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_disasterpreventionbloc(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_disasterpreventionblocs
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_disasterpreventionbloc t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_urbandevelopmentproj_2
    PERFORM citydb.del_ur_urbandevelopmentproj_2(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_disasterpreventionbloc(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_disasterpreventionbloc(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_disasterriskattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  IF $2 <> 2 THEN
    FOR rec IN
      SELECT
        co.id, co.objectclass_id
      FROM
        citydb.cityobject co, unnest($1) a(a_id)
      WHERE
        co.id = a.a_id
    LOOP
      object_id := rec.id::bigint;
      objectclass_id := rec.objectclass_id::integer;
      CASE
        -- delete ur_floodingriskattribute
        WHEN objectclass_id = 60053 THEN
          dummy_id := citydb.del_ur_floodingriskattribute(array_agg(object_id), 1);
        -- delete ur_riverfloodingriskattri
        WHEN objectclass_id = 60180 THEN
          dummy_id := citydb.del_ur_riverfloodingriskattri(array_agg(object_id), 0);
        -- delete ur_floodingriskattribute
        WHEN objectclass_id = 60181 THEN
          dummy_id := citydb.del_ur_floodingriskattribute(array_agg(object_id), 1);
        -- delete ur_floodingriskattribute
        WHEN objectclass_id = 60182 THEN
          dummy_id := citydb.del_ur_floodingriskattribute(array_agg(object_id), 1);
        -- delete ur_floodingriskattribute
        WHEN objectclass_id = 60183 THEN
          dummy_id := citydb.del_ur_floodingriskattribute(array_agg(object_id), 1);
        -- delete ur_floodingriskattribute
        WHEN objectclass_id = 60184 THEN
          dummy_id := citydb.del_ur_floodingriskattribute(array_agg(object_id), 1);
        ELSE
          dummy_id := NULL;
      END CASE;

      IF dummy_id = object_id THEN
        deleted_child_ids := array_append(deleted_child_ids, dummy_id);
      END IF;
    END LOOP;
  END IF;

  -- delete citydb.ur_disasterriskattributes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_disasterriskattribute t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_disasterriskattribute(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_disasterriskattribute(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_distributionbusinesspa(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_distributionbusinesspas
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_distributionbusinesspa t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_urbanfacility
    PERFORM citydb.del_ur_urbanfacility(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_distributionbusinesspa(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_distributionbusinesspa(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_distributionbusinesszo(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_distributionbusinesszos
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_distributionbusinesszo t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_districtsandzones
    PERFORM citydb.del_ur_districtsandzones(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_distributionbusinesszo(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_distributionbusinesszo(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_district(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_districts
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_district t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_zone
    PERFORM citydb.del_ur_zone(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_district(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_district(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_districtdevelopmentpla(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  IF $2 <> 2 THEN
    FOR rec IN
      SELECT
        co.id, co.objectclass_id
      FROM
        citydb.cityobject co, unnest($1) a(a_id)
      WHERE
        co.id = a.a_id
    LOOP
      object_id := rec.id::bigint;
      objectclass_id := rec.objectclass_id::integer;
      CASE
        -- delete ur_roadsidedistrictimprov
        WHEN objectclass_id = 60379 THEN
          dummy_id := citydb.del_ur_roadsidedistrictimprov(array_agg(object_id), 1);
        -- delete ur_ruraldistrictimproveme
        WHEN objectclass_id = 60380 THEN
          dummy_id := citydb.del_ur_ruraldistrictimproveme(array_agg(object_id), 1);
        ELSE
          dummy_id := NULL;
      END CASE;

      IF dummy_id = object_id THEN
        deleted_child_ids := array_append(deleted_child_ids, dummy_id);
      END IF;
    END LOOP;
  END IF;

  -- delete citydb.ur_districtdevelopmentplas
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_districtdevelopmentpla t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_zone
    PERFORM citydb.del_ur_zone(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_districtdevelopmentpla(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_districtdevelopmentpla(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_districtplan(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_districtplans
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_districtplan t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_abstractdistrictplan
    PERFORM citydb.del_ur_abstractdistrictplan(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_districtplan(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_districtplan(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_districtsandzones(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  IF $2 <> 2 THEN
    FOR rec IN
      SELECT
        co.id, co.objectclass_id
      FROM
        citydb.cityobject co, unnest($1) a(a_id)
      WHERE
        co.id = a.a_id
    LOOP
      object_id := rec.id::bigint;
      objectclass_id := rec.objectclass_id::integer;
      CASE
        -- delete ur_usedistrict
        WHEN objectclass_id = 60309 THEN
          dummy_id := citydb.del_ur_usedistrict(array_agg(object_id), 1);
        -- delete ur_specialusedistrict
        WHEN objectclass_id = 60310 THEN
          dummy_id := citydb.del_ur_specialusedistrict(array_agg(object_id), 1);
        -- delete ur_specialuserestrictiond
        WHEN objectclass_id = 60311 THEN
          dummy_id := citydb.del_ur_specialuserestrictiond(array_agg(object_id), 1);
        -- delete ur_exceptionalfloorareara
        WHEN objectclass_id = 60312 THEN
          dummy_id := citydb.del_ur_exceptionalfloorareara(array_agg(object_id), 1);
        -- delete ur_highriseresidentialatt
        WHEN objectclass_id = 60313 THEN
          dummy_id := citydb.del_ur_highriseresidentialatt(array_agg(object_id), 1);
        -- delete ur_heightcontroldistrict
        WHEN objectclass_id = 60314 THEN
          dummy_id := citydb.del_ur_heightcontroldistrict(array_agg(object_id), 1);
        -- delete ur_highlevelusedistrict
        WHEN objectclass_id = 60315 THEN
          dummy_id := citydb.del_ur_highlevelusedistrict(array_agg(object_id), 1);
        -- delete ur_specifiedblock
        WHEN objectclass_id = 60316 THEN
          dummy_id := citydb.del_ur_specifiedblock(array_agg(object_id), 1);
        -- delete ur_specialurbanrenaissanc
        WHEN objectclass_id = 60317 THEN
          dummy_id := citydb.del_ur_specialurbanrenaissanc(array_agg(object_id), 1);
        -- delete ur_residentialenvironment
        WHEN objectclass_id = 60319 THEN
          dummy_id := citydb.del_ur_residentialenvironment(array_agg(object_id), 1);
        -- delete ur_specialuseattractiondi
        WHEN objectclass_id = 60320 THEN
          dummy_id := citydb.del_ur_specialuseattractiondi(array_agg(object_id), 1);
        -- delete ur_specifieddisasterpreve
        WHEN objectclass_id = 60322 THEN
          dummy_id := citydb.del_ur_specifieddisasterpreve(array_agg(object_id), 1);
        -- delete ur_landscapezone
        WHEN objectclass_id = 60323 THEN
          dummy_id := citydb.del_ur_landscapezone(array_agg(object_id), 1);
        -- delete ur_scenicdistrict
        WHEN objectclass_id = 60324 THEN
          dummy_id := citydb.del_ur_scenicdistrict(array_agg(object_id), 1);
        -- delete ur_portzone
        WHEN objectclass_id = 60326 THEN
          dummy_id := citydb.del_ur_portzone(array_agg(object_id), 1);
        -- delete ur_specialgreenspaceconse
        WHEN objectclass_id = 60330 THEN
          dummy_id := citydb.del_ur_specialgreenspaceconse(array_agg(object_id), 1);
        -- delete ur_treeplantingdistrict
        WHEN objectclass_id = 60331 THEN
          dummy_id := citydb.del_ur_treeplantingdistrict(array_agg(object_id), 1);
        -- delete ur_distributionbusinesszo
        WHEN objectclass_id = 60332 THEN
          dummy_id := citydb.del_ur_distributionbusinesszo(array_agg(object_id), 1);
        -- delete ur_productivegreenzone
        WHEN objectclass_id = 60333 THEN
          dummy_id := citydb.del_ur_productivegreenzone(array_agg(object_id), 1);
        ELSE
          dummy_id := NULL;
      END CASE;

      IF dummy_id = object_id THEN
        deleted_child_ids := array_append(deleted_child_ids, dummy_id);
      END IF;
    END LOOP;
  END IF;

  -- delete citydb.ur_districtsandzoness
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_districtsandzones t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_zone
    PERFORM citydb.del_ur_zone(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_districtsandzones(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_districtsandzones(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_dmannotation(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  surface_geometry_ids bigint[] := '{}';
BEGIN
  -- delete citydb.ur_dmannotations
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_dmannotation t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      lod0anchorpoint_brep_id
  )
  SELECT
    array_agg(id),
    array_agg(lod0anchorpoint_brep_id)
  INTO
    deleted_ids,
    surface_geometry_ids
  FROM
    delete_objects;

  -- delete citydb.surface_geometry(s)
  IF -1 = ALL(surface_geometry_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_surface_geometry(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(surface_geometry_ids) AS a_id) a;
  END IF;

  IF $2 <> 1 THEN
    -- delete ur_dmattribute
    PERFORM citydb.del_ur_dmattribute(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_dmannotation(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_dmannotation(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_dmattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_dmelement_ids bigint[] := '{}';
BEGIN
  IF $2 <> 2 THEN
    FOR rec IN
      SELECT
        co.id, co.objectclass_id
      FROM
        citydb.cityobject co, unnest($1) a(a_id)
      WHERE
        co.id = a.a_id
    LOOP
      object_id := rec.id::bigint;
      objectclass_id := rec.objectclass_id::integer;
      CASE
        -- delete ur_dmgeometricattribute
        WHEN objectclass_id = 60177 THEN
          dummy_id := citydb.del_ur_dmgeometricattribute(array_agg(object_id), 1);
        -- delete ur_dmannotation
        WHEN objectclass_id = 60178 THEN
          dummy_id := citydb.del_ur_dmannotation(array_agg(object_id), 1);
        ELSE
          dummy_id := NULL;
      END CASE;

      IF dummy_id = object_id THEN
        deleted_child_ids := array_append(deleted_child_ids, dummy_id);
      END IF;
    END LOOP;
  END IF;

  -- delete citydb.ur_dmattributes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_dmattribute t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      dmelement_id
  )
  SELECT
    array_agg(id),
    array_agg(dmelement_id)
  INTO
    deleted_ids,
    ur_dmelement_ids
  FROM
    delete_objects;

  -- delete citydb.ur_dmelement(s)
  IF -1 = ALL(ur_dmelement_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_dmelement(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_dmelement_ids) AS a_id) a;
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_dmattribute(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_dmattribute(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_dmelement(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_dmelements
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_dmelement t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_dmelement(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_dmelement(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_dmgeometricattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  surface_geometry_ids bigint[] := '{}';
BEGIN
  -- delete citydb.ur_dmgeometricattributes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_dmgeometricattribute t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      lod0geometry_brep_id
  )
  SELECT
    array_agg(id),
    array_agg(lod0geometry_brep_id)
  INTO
    deleted_ids,
    surface_geometry_ids
  FROM
    delete_objects;

  -- delete citydb.surface_geometry(s)
  IF -1 = ALL(surface_geometry_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_surface_geometry(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(surface_geometry_ids) AS a_id) a;
  END IF;

  IF $2 <> 1 THEN
    -- delete ur_dmattribute
    PERFORM citydb.del_ur_dmattribute(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_dmgeometricattribute(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_dmgeometricattribute(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_economicactivitysumtyp(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_economicactivitysumtyps
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_economicactivitysumtyp t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_economicactivitysumtyp(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_economicactivitysumtyp(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_economicactivitytype(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  --delete ur_economicactivitysumtyps
  PERFORM
    citydb.del_ur_economicactivitysumtyp(array_agg(t.id))
  FROM
    citydb.ur_economicactivitysumtyp t,
    unnest($1) a(a_id)
  WHERE
    t.economicactivitytype_manu_id = a.a_id;

  --delete ur_economicactivitysumtyps
  PERFORM
    citydb.del_ur_economicactivitysumtyp(array_agg(t.id))
  FROM
    citydb.ur_economicactivitysumtyp t,
    unnest($1) a(a_id)
  WHERE
    t.economicactivitytype_numb__2 = a.a_id;

  --delete ur_economicactivitysumtyps
  PERFORM
    citydb.del_ur_economicactivitysumtyp(array_agg(t.id))
  FROM
    citydb.ur_economicactivitysumtyp t,
    unnest($1) a(a_id)
  WHERE
    t.economicactivitytype_numb_id = a.a_id;

  --delete ur_economicactivitysumtyps
  PERFORM
    citydb.del_ur_economicactivitysumtyp(array_agg(t.id))
  FROM
    citydb.ur_economicactivitysumtyp t,
    unnest($1) a(a_id)
  WHERE
    t.economicactivitytype_reta_id = a.a_id;

  -- delete citydb.ur_economicactivitytypes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_economicactivitytype t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_economicactivitytype(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_economicactivitytype(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_elevation(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_elevations
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_elevation t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_elevation(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_elevation(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_embankmentattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_embankmentattributes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_embankmentattribute t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_constructionstructurea
    PERFORM citydb.del_ur_constructionstructurea(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_embankmentattribute(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_embankmentattribute(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_exceptionalfloorareara(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_exceptionalfloorarearas
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_exceptionalfloorareara t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_districtsandzones
    PERFORM citydb.del_ur_districtsandzones(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_exceptionalfloorareara(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_exceptionalfloorareara(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_facilityattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  IF $2 <> 2 THEN
    FOR rec IN
      SELECT
        co.id, co.objectclass_id
      FROM
        citydb.cityobject co, unnest($1) a(a_id)
      WHERE
        co.id = a.a_id
    LOOP
      object_id := rec.id::bigint;
      objectclass_id := rec.objectclass_id::integer;
      CASE
        -- delete ur_parkfacilitylongevityp
        WHEN objectclass_id = 60055 THEN
          dummy_id := citydb.del_ur_parkfacilitylongevityp(array_agg(object_id), 1);
        -- delete ur_portattribute
        WHEN objectclass_id = 60062 THEN
          dummy_id := citydb.del_ur_portattribute(array_agg(object_id), 1);
        -- delete ur_harborfacility
        WHEN objectclass_id = 60063 THEN
          dummy_id := citydb.del_ur_harborfacility(array_agg(object_id), 0);
        -- delete ur_portprotectivefacility
        WHEN objectclass_id = 60064 THEN
          dummy_id := citydb.del_ur_portprotectivefacility(array_agg(object_id), 0);
        -- delete ur_mooringfacility
        WHEN objectclass_id = 60065 THEN
          dummy_id := citydb.del_ur_mooringfacility(array_agg(object_id), 0);
        -- delete ur_porttransportationfaci
        WHEN objectclass_id = 60066 THEN
          dummy_id := citydb.del_ur_porttransportationfaci(array_agg(object_id), 0);
        -- delete ur_navigationassistancefa
        WHEN objectclass_id = 60067 THEN
          dummy_id := citydb.del_ur_navigationassistancefa(array_agg(object_id), 0);
        -- delete ur_cargohandlingfacility
        WHEN objectclass_id = 60068 THEN
          dummy_id := citydb.del_ur_cargohandlingfacility(array_agg(object_id), 0);
        -- delete ur_portpassengerfacility
        WHEN objectclass_id = 60069 THEN
          dummy_id := citydb.del_ur_portpassengerfacility(array_agg(object_id), 0);
        -- delete ur_portstoragefacility
        WHEN objectclass_id = 60070 THEN
          dummy_id := citydb.del_ur_portstoragefacility(array_agg(object_id), 0);
        -- delete ur_shipservicefacility
        WHEN objectclass_id = 60071 THEN
          dummy_id := citydb.del_ur_shipservicefacility(array_agg(object_id), 0);
        -- delete ur_portwastetreatmentfaci
        WHEN objectclass_id = 60072 THEN
          dummy_id := citydb.del_ur_portwastetreatmentfaci(array_agg(object_id), 0);
        -- delete ur_portenvironmentalimpro
        WHEN objectclass_id = 60073 THEN
          dummy_id := citydb.del_ur_portenvironmentalimpro(array_agg(object_id), 0);
        -- delete ur_portpollutioncontrolfa
        WHEN objectclass_id = 60074 THEN
          dummy_id := citydb.del_ur_portpollutioncontrolfa(array_agg(object_id), 0);
        -- delete ur_portwelfarefacility
        WHEN objectclass_id = 60075 THEN
          dummy_id := citydb.del_ur_portwelfarefacility(array_agg(object_id), 0);
        -- delete ur_portmanagementfacility
        WHEN objectclass_id = 60076 THEN
          dummy_id := citydb.del_ur_portmanagementfacility(array_agg(object_id), 0);
        -- delete ur_cyberportmarinaandpbs
        WHEN objectclass_id = 60077 THEN
          dummy_id := citydb.del_ur_cyberportmarinaandpbs(array_agg(object_id), 0);
        -- delete ur_fishingportattribute
        WHEN objectclass_id = 60078 THEN
          dummy_id := citydb.del_ur_fishingportattribute(array_agg(object_id), 1);
        -- delete ur_fishingportfacility
        WHEN objectclass_id = 60079 THEN
          dummy_id := citydb.del_ur_fishingportfacility(array_agg(object_id), 0);
        -- delete ur_fishingportcapacity
        WHEN objectclass_id = 60080 THEN
          dummy_id := citydb.del_ur_fishingportcapacity(array_agg(object_id), 0);
        -- delete ur_maintenancehistoryattr
        WHEN objectclass_id = 60127 THEN
          dummy_id := citydb.del_ur_maintenancehistoryattr(array_agg(object_id), 1);
        ELSE
          dummy_id := NULL;
      END CASE;

      IF dummy_id = object_id THEN
        deleted_child_ids := array_append(deleted_child_ids, dummy_id);
      END IF;
    END LOOP;
  END IF;

  -- delete citydb.ur_facilityattributes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_facilityattribute t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_facilityattribute(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_facilityattribute(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_facilityidattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  IF $2 <> 2 THEN
    FOR rec IN
      SELECT
        co.id, co.objectclass_id
      FROM
        citydb.cityobject co, unnest($1) a(a_id)
      WHERE
        co.id = a.a_id
    LOOP
      object_id := rec.id::bigint;
      objectclass_id := rec.objectclass_id::integer;
      CASE
        -- delete ur_riverfacilityidattribu
        WHEN objectclass_id = 60061 THEN
          dummy_id := citydb.del_ur_riverfacilityidattribu(array_agg(object_id), 1);
        ELSE
          dummy_id := NULL;
      END CASE;

      IF dummy_id = object_id THEN
        deleted_child_ids := array_append(deleted_child_ids, dummy_id);
      END IF;
    END LOOP;
  END IF;

  -- delete citydb.ur_facilityidattributes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_facilityidattribute t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_facilityidattribute(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_facilityidattribute(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_facilitytypeattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_facilitytypeattributes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_facilitytypeattribute t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_facilitytypeattribute(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_facilitytypeattribute(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_fareattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_fareattributes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_fareattribute t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_publictransit
    PERFORM citydb.del_ur_publictransit(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_fareattribute(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_fareattribute(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_farerule(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_farerules
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_farerule t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_publictransitdatatype
    PERFORM citydb.del_ur_publictransitdatatype(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_farerule(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_farerule(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_farmlandconversiontype(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_farmlandconversiontypes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_farmlandconversiontype t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_farmlandconversiontype(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_farmlandconversiontype(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_feedinfo(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_feedinfos
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_feedinfo t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_publictransitdatatype
    PERFORM citydb.del_ur_publictransitdatatype(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_feedinfo(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_feedinfo(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_fishingportattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  IF $2 <> 2 THEN
    FOR rec IN
      SELECT
        co.id, co.objectclass_id
      FROM
        citydb.cityobject co, unnest($1) a(a_id)
      WHERE
        co.id = a.a_id
    LOOP
      object_id := rec.id::bigint;
      objectclass_id := rec.objectclass_id::integer;
      CASE
        -- delete ur_fishingportfacility
        WHEN objectclass_id = 60079 THEN
          dummy_id := citydb.del_ur_fishingportfacility(array_agg(object_id), 1);
        -- delete ur_fishingportcapacity
        WHEN objectclass_id = 60080 THEN
          dummy_id := citydb.del_ur_fishingportcapacity(array_agg(object_id), 1);
        ELSE
          dummy_id := NULL;
      END CASE;

      IF dummy_id = object_id THEN
        deleted_child_ids := array_append(deleted_child_ids, dummy_id);
      END IF;
    END LOOP;
  END IF;

  -- delete citydb.ur_fishingportattributes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_fishingportattribute t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_facilityattribute
    PERFORM citydb.del_ur_facilityattribute(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_fishingportattribute(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_fishingportattribute(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_fishingportcapacity(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_fishingportcapacitys
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_fishingportcapacity t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_fishingportattribute
    PERFORM citydb.del_ur_fishingportattribute(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_fishingportcapacity(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_fishingportcapacity(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_fishingportfacility(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_fishingportfacilitys
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_fishingportfacility t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_fishingportattribute
    PERFORM citydb.del_ur_fishingportattribute(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_fishingportfacility(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_fishingportfacility(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_floodingriskattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  IF $2 <> 2 THEN
    FOR rec IN
      SELECT
        co.id, co.objectclass_id
      FROM
        citydb.cityobject co, unnest($1) a(a_id)
      WHERE
        co.id = a.a_id
    LOOP
      object_id := rec.id::bigint;
      objectclass_id := rec.objectclass_id::integer;
      CASE
        -- delete ur_riverfloodingriskattri
        WHEN objectclass_id = 60180 THEN
          dummy_id := citydb.del_ur_riverfloodingriskattri(array_agg(object_id), 1);
        ELSE
          dummy_id := NULL;
      END CASE;

      IF dummy_id = object_id THEN
        deleted_child_ids := array_append(deleted_child_ids, dummy_id);
      END IF;
    END LOOP;
  END IF;

  -- delete citydb.ur_floodingriskattributes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_floodingriskattribute t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_disasterriskattribute
    PERFORM citydb.del_ur_disasterriskattribute(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_floodingriskattribute(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_floodingriskattribute(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_forestconversiontype(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_forestconversiontypes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_forestconversiontype t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_forestconversiontype(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_forestconversiontype(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_frequency(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_frequencys
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_frequency t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_publictransitdatatype
    PERFORM citydb.del_ur_publictransitdatatype(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_frequency(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_frequency(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_globalhubcitydevelopme(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_globalhubcitydevelopmes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_globalhubcitydevelopme t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_zone
    PERFORM citydb.del_ur_zone(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_globalhubcitydevelopme(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_globalhubcitydevelopme(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_harborfacility(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_harborfacilitys
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_harborfacility t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_portattribute
    PERFORM citydb.del_ur_portattribute(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_harborfacility(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_harborfacility(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_height(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_heights
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_height t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_height(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_height(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_heightcontroldistrict(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_heightcontroldistricts
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_heightcontroldistrict t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_districtsandzones
    PERFORM citydb.del_ur_districtsandzones(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_heightcontroldistrict(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_heightcontroldistrict(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_highlevelusedistrict(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_highlevelusedistricts
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_highlevelusedistrict t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_districtsandzones
    PERFORM citydb.del_ur_districtsandzones(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_highlevelusedistrict(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_highlevelusedistrict(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_highriseresidentialatt(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_highriseresidentialatts
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_highriseresidentialatt t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_districtsandzones
    PERFORM citydb.del_ur_districtsandzones(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_highriseresidentialatt(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_highriseresidentialatt(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_historicscenerymainten(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_historicscenerymaintens
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_historicscenerymainten t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_abstractdistrictplan
    PERFORM citydb.del_ur_abstractdistrictplan(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_historicscenerymainten(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_historicscenerymainten(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_households(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  --delete ur_numberofhouseholdss
  PERFORM
    citydb.del_ur_numberofhouseholds(array_agg(t.id))
  FROM
    citydb.ur_numberofhouseholds t,
    unnest($1) a(a_id)
  WHERE
    t.households_numberofhous_id_1 = a.a_id;

  --delete ur_numberofhouseholdss
  PERFORM
    citydb.del_ur_numberofhouseholds(array_agg(t.id))
  FROM
    citydb.ur_numberofhouseholds t,
    unnest($1) a(a_id)
  WHERE
    t.households_numberofhouseh_id = a.a_id;

  -- delete citydb.ur_householdss
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_households t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_statisticalgrid
    PERFORM citydb.del_ur_statisticalgrid(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_households(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_households(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifcattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  IF $2 <> 2 THEN
    FOR rec IN
      SELECT
        co.id, co.objectclass_id
      FROM
        citydb.cityobject co, unnest($1) a(a_id)
      WHERE
        co.id = a.a_id
    LOOP
      object_id := rec.id::bigint;
      objectclass_id := rec.objectclass_id::integer;
      CASE
        -- delete ur_ifcroot
        WHEN objectclass_id = 60128 THEN
          dummy_id := citydb.del_ur_ifcroot(array_agg(object_id), 1);
        -- delete ur_ifcroot
        WHEN objectclass_id = 60129 THEN
          dummy_id := citydb.del_ur_ifcroot(array_agg(object_id), 1);
        -- delete ur_ifcroot
        WHEN objectclass_id = 60130 THEN
          dummy_id := citydb.del_ur_ifcroot(array_agg(object_id), 1);
        -- delete ur_ifcproduct
        WHEN objectclass_id = 60131 THEN
          dummy_id := citydb.del_ur_ifcproduct(array_agg(object_id), 0);
        -- delete ur_ifcspatialstructureele
        WHEN objectclass_id = 60132 THEN
          dummy_id := citydb.del_ur_ifcspatialstructureele(array_agg(object_id), 0);
        -- delete ur_ifcbuilding
        WHEN objectclass_id = 60133 THEN
          dummy_id := citydb.del_ur_ifcbuilding(array_agg(object_id), 0);
        -- delete ur_ifcpsetbuildingcommon
        WHEN objectclass_id = 60134 THEN
          dummy_id := citydb.del_ur_ifcpsetbuildingcommon(array_agg(object_id), 1);
        -- delete ur_ifcsite
        WHEN objectclass_id = 60135 THEN
          dummy_id := citydb.del_ur_ifcsite(array_agg(object_id), 0);
        -- delete ur_ifcpsetsitecommon
        WHEN objectclass_id = 60136 THEN
          dummy_id := citydb.del_ur_ifcpsetsitecommon(array_agg(object_id), 1);
        -- delete ur_ifcproject
        WHEN objectclass_id = 60137 THEN
          dummy_id := citydb.del_ur_ifcproject(array_agg(object_id), 0);
        -- delete ur_ifccoordinatereference
        WHEN objectclass_id = 60141 THEN
          dummy_id := citydb.del_ur_ifccoordinatereference(array_agg(object_id), 1);
        -- delete ur_ifcprojectedcrs
        WHEN objectclass_id = 60142 THEN
          dummy_id := citydb.del_ur_ifcprojectedcrs(array_agg(object_id), 0);
        -- delete ur_ifcmapconversion
        WHEN objectclass_id = 60143 THEN
          dummy_id := citydb.del_ur_ifcmapconversion(array_agg(object_id), 1);
        -- delete ur_ifcspace
        WHEN objectclass_id = 60146 THEN
          dummy_id := citydb.del_ur_ifcspace(array_agg(object_id), 0);
        -- delete ur_ifcclassificationrefer
        WHEN objectclass_id = 60147 THEN
          dummy_id := citydb.del_ur_ifcclassificationrefer(array_agg(object_id), 1);
        -- delete ur_ifcpsetspacecommon
        WHEN objectclass_id = 60149 THEN
          dummy_id := citydb.del_ur_ifcpsetspacecommon(array_agg(object_id), 1);
        -- delete ur_ifcspacebasequantity
        WHEN objectclass_id = 60150 THEN
          dummy_id := citydb.del_ur_ifcspacebasequantity(array_agg(object_id), 1);
        -- delete ur_ifcelement
        WHEN objectclass_id = 60151 THEN
          dummy_id := citydb.del_ur_ifcelement(array_agg(object_id), 0);
        -- delete ur_ifcbuildingelement
        WHEN objectclass_id = 60152 THEN
          dummy_id := citydb.del_ur_ifcbuildingelement(array_agg(object_id), 0);
        -- delete ur_ifcwall
        WHEN objectclass_id = 60153 THEN
          dummy_id := citydb.del_ur_ifcwall(array_agg(object_id), 0);
        -- delete ur_ifcwall
        WHEN objectclass_id = 60154 THEN
          dummy_id := citydb.del_ur_ifcwall(array_agg(object_id), 0);
        -- delete ur_ifcbuildingelement
        WHEN objectclass_id = 60155 THEN
          dummy_id := citydb.del_ur_ifcbuildingelement(array_agg(object_id), 0);
        -- delete ur_ifcbuildingelement
        WHEN objectclass_id = 60156 THEN
          dummy_id := citydb.del_ur_ifcbuildingelement(array_agg(object_id), 0);
        -- delete ur_ifcwindow
        WHEN objectclass_id = 60157 THEN
          dummy_id := citydb.del_ur_ifcwindow(array_agg(object_id), 0);
        -- delete ur_ifcdoor
        WHEN objectclass_id = 60158 THEN
          dummy_id := citydb.del_ur_ifcdoor(array_agg(object_id), 0);
        -- delete ur_ifcopeningelement
        WHEN objectclass_id = 60159 THEN
          dummy_id := citydb.del_ur_ifcopeningelement(array_agg(object_id), 0);
        -- delete ur_ifcpsetwindowcommon
        WHEN objectclass_id = 60160 THEN
          dummy_id := citydb.del_ur_ifcpsetwindowcommon(array_agg(object_id), 1);
        -- delete ur_ifcpsetdoorcommon
        WHEN objectclass_id = 60161 THEN
          dummy_id := citydb.del_ur_ifcpsetdoorcommon(array_agg(object_id), 1);
        -- delete ur_ifcpsetopeningelementc
        WHEN objectclass_id = 60162 THEN
          dummy_id := citydb.del_ur_ifcpsetopeningelementc(array_agg(object_id), 1);
        -- delete ur_ifcelement
        WHEN objectclass_id = 60163 THEN
          dummy_id := citydb.del_ur_ifcelement(array_agg(object_id), 0);
        -- delete ur_ifcspatialstructureele
        WHEN objectclass_id = 60164 THEN
          dummy_id := citydb.del_ur_ifcspatialstructureele(array_agg(object_id), 0);
        -- delete ur_ifcroot
        WHEN objectclass_id = 60165 THEN
          dummy_id := citydb.del_ur_ifcroot(array_agg(object_id), 1);
        -- delete ur_ifcroot
        WHEN objectclass_id = 60166 THEN
          dummy_id := citydb.del_ur_ifcroot(array_agg(object_id), 1);
        ELSE
          dummy_id := NULL;
      END CASE;

      IF dummy_id = object_id THEN
        deleted_child_ids := array_append(deleted_child_ids, dummy_id);
      END IF;
    END LOOP;
  END IF;

  -- delete citydb.ur_ifcattributes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_ifcattribute t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifcattribute(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_ifcattribute(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifcbuilding(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_ifcbuildings
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_ifcbuilding t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_ifcspatialstructureele
    PERFORM citydb.del_ur_ifcspatialstructureele(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifcbuilding(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_ifcbuilding(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifcbuildingelement(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  IF $2 <> 2 THEN
    FOR rec IN
      SELECT
        co.id, co.objectclass_id
      FROM
        citydb.cityobject co, unnest($1) a(a_id)
      WHERE
        co.id = a.a_id
    LOOP
      object_id := rec.id::bigint;
      objectclass_id := rec.objectclass_id::integer;
      CASE
        -- delete ur_ifcwall
        WHEN objectclass_id = 60153 THEN
          dummy_id := citydb.del_ur_ifcwall(array_agg(object_id), 1);
        -- delete ur_ifcwall
        WHEN objectclass_id = 60154 THEN
          dummy_id := citydb.del_ur_ifcwall(array_agg(object_id), 1);
        -- delete ur_ifcwindow
        WHEN objectclass_id = 60157 THEN
          dummy_id := citydb.del_ur_ifcwindow(array_agg(object_id), 1);
        -- delete ur_ifcdoor
        WHEN objectclass_id = 60158 THEN
          dummy_id := citydb.del_ur_ifcdoor(array_agg(object_id), 1);
        ELSE
          dummy_id := NULL;
      END CASE;

      IF dummy_id = object_id THEN
        deleted_child_ids := array_append(deleted_child_ids, dummy_id);
      END IF;
    END LOOP;
  END IF;

  -- delete citydb.ur_ifcbuildingelements
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_ifcbuildingelement t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_ifcelement
    PERFORM citydb.del_ur_ifcelement(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifcbuildingelement(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_ifcbuildingelement(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifcclassification(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_ifcclassifications
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_ifcclassification t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifcclassification(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_ifcclassification(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifcclassificationrefer(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_ifcclassification_ids bigint[] := '{}';
BEGIN
  -- delete citydb.ur_ifcclassificationrefers
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_ifcclassificationrefer t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      referencedsource_id
  )
  SELECT
    array_agg(id),
    array_agg(referencedsource_id)
  INTO
    deleted_ids,
    ur_ifcclassification_ids
  FROM
    delete_objects;

  -- delete citydb.ur_ifcclassification(s)
  IF -1 = ALL(ur_ifcclassification_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_ifcclassification(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_ifcclassification_ids) AS a_id) a;
  END IF;

  IF $2 <> 1 THEN
    -- delete ur_ifcattribute
    PERFORM citydb.del_ur_ifcattribute(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifcclassificationrefer(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_ifcclassificationrefer(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifccoordinatereference(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  IF $2 <> 2 THEN
    FOR rec IN
      SELECT
        co.id, co.objectclass_id
      FROM
        citydb.cityobject co, unnest($1) a(a_id)
      WHERE
        co.id = a.a_id
    LOOP
      object_id := rec.id::bigint;
      objectclass_id := rec.objectclass_id::integer;
      CASE
        -- delete ur_ifcprojectedcrs
        WHEN objectclass_id = 60142 THEN
          dummy_id := citydb.del_ur_ifcprojectedcrs(array_agg(object_id), 1);
        ELSE
          dummy_id := NULL;
      END CASE;

      IF dummy_id = object_id THEN
        deleted_child_ids := array_append(deleted_child_ids, dummy_id);
      END IF;
    END LOOP;
  END IF;

  -- delete citydb.ur_ifccoordinatereferences
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_ifccoordinatereference t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_ifcattribute
    PERFORM citydb.del_ur_ifcattribute(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifccoordinatereference(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_ifccoordinatereference(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifcdoor(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_ifcdoors
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_ifcdoor t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_ifcbuildingelement
    PERFORM citydb.del_ur_ifcbuildingelement(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifcdoor(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_ifcdoor(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifcelement(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  IF $2 <> 2 THEN
    FOR rec IN
      SELECT
        co.id, co.objectclass_id
      FROM
        citydb.cityobject co, unnest($1) a(a_id)
      WHERE
        co.id = a.a_id
    LOOP
      object_id := rec.id::bigint;
      objectclass_id := rec.objectclass_id::integer;
      CASE
        -- delete ur_ifcbuildingelement
        WHEN objectclass_id = 60152 THEN
          dummy_id := citydb.del_ur_ifcbuildingelement(array_agg(object_id), 1);
        -- delete ur_ifcwall
        WHEN objectclass_id = 60153 THEN
          dummy_id := citydb.del_ur_ifcwall(array_agg(object_id), 0);
        -- delete ur_ifcwall
        WHEN objectclass_id = 60154 THEN
          dummy_id := citydb.del_ur_ifcwall(array_agg(object_id), 0);
        -- delete ur_ifcbuildingelement
        WHEN objectclass_id = 60155 THEN
          dummy_id := citydb.del_ur_ifcbuildingelement(array_agg(object_id), 1);
        -- delete ur_ifcbuildingelement
        WHEN objectclass_id = 60156 THEN
          dummy_id := citydb.del_ur_ifcbuildingelement(array_agg(object_id), 1);
        -- delete ur_ifcwindow
        WHEN objectclass_id = 60157 THEN
          dummy_id := citydb.del_ur_ifcwindow(array_agg(object_id), 0);
        -- delete ur_ifcdoor
        WHEN objectclass_id = 60158 THEN
          dummy_id := citydb.del_ur_ifcdoor(array_agg(object_id), 0);
        -- delete ur_ifcopeningelement
        WHEN objectclass_id = 60159 THEN
          dummy_id := citydb.del_ur_ifcopeningelement(array_agg(object_id), 1);
        ELSE
          dummy_id := NULL;
      END CASE;

      IF dummy_id = object_id THEN
        deleted_child_ids := array_append(deleted_child_ids, dummy_id);
      END IF;
    END LOOP;
  END IF;

  -- delete citydb.ur_ifcelements
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_ifcelement t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_ifcproduct
    PERFORM citydb.del_ur_ifcproduct(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifcelement(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_ifcelement(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifcgeometricrepresenta(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_ifcgeometricrepresentas
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_ifcgeometricrepresenta t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifcgeometricrepresenta(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_ifcgeometricrepresenta(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifcmapconversion(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_crs_ids bigint[] := '{}';
  ur_ifccoordinatereference_ids bigint[] := '{}';
BEGIN
  -- delete citydb.ur_ifcmapconversions
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_ifcmapconversion t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      sourcecrs_id,
      targetcrs_id
  )
  SELECT
    array_agg(id),
    array_agg(sourcecrs_id),
    array_agg(targetcrs_id)
  INTO
    deleted_ids,
    ur_crs_ids,
    ur_ifccoordinatereference_ids
  FROM
    delete_objects;

  -- delete citydb.ur_crs(s)
  IF -1 = ALL(ur_crs_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_crs(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_crs_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_ifccoordinatereference(s)
  IF -1 = ALL(ur_ifccoordinatereference_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_ifccoordinatereference(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_ifccoordinatereference_ids) AS a_id) a;
  END IF;

  IF $2 <> 1 THEN
    -- delete ur_ifcattribute
    PERFORM citydb.del_ur_ifcattribute(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifcmapconversion(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_ifcmapconversion(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifcopeningelement(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_ifcopeningelements
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_ifcopeningelement t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_ifcelement
    PERFORM citydb.del_ur_ifcelement(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifcopeningelement(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_ifcopeningelement(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifcproduct(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  IF $2 <> 2 THEN
    FOR rec IN
      SELECT
        co.id, co.objectclass_id
      FROM
        citydb.cityobject co, unnest($1) a(a_id)
      WHERE
        co.id = a.a_id
    LOOP
      object_id := rec.id::bigint;
      objectclass_id := rec.objectclass_id::integer;
      CASE
        -- delete ur_ifcspatialstructureele
        WHEN objectclass_id = 60132 THEN
          dummy_id := citydb.del_ur_ifcspatialstructureele(array_agg(object_id), 1);
        -- delete ur_ifcbuilding
        WHEN objectclass_id = 60133 THEN
          dummy_id := citydb.del_ur_ifcbuilding(array_agg(object_id), 0);
        -- delete ur_ifcsite
        WHEN objectclass_id = 60135 THEN
          dummy_id := citydb.del_ur_ifcsite(array_agg(object_id), 0);
        -- delete ur_ifcspace
        WHEN objectclass_id = 60146 THEN
          dummy_id := citydb.del_ur_ifcspace(array_agg(object_id), 0);
        -- delete ur_ifcelement
        WHEN objectclass_id = 60151 THEN
          dummy_id := citydb.del_ur_ifcelement(array_agg(object_id), 1);
        -- delete ur_ifcbuildingelement
        WHEN objectclass_id = 60152 THEN
          dummy_id := citydb.del_ur_ifcbuildingelement(array_agg(object_id), 0);
        -- delete ur_ifcwall
        WHEN objectclass_id = 60153 THEN
          dummy_id := citydb.del_ur_ifcwall(array_agg(object_id), 0);
        -- delete ur_ifcwall
        WHEN objectclass_id = 60154 THEN
          dummy_id := citydb.del_ur_ifcwall(array_agg(object_id), 0);
        -- delete ur_ifcbuildingelement
        WHEN objectclass_id = 60155 THEN
          dummy_id := citydb.del_ur_ifcbuildingelement(array_agg(object_id), 0);
        -- delete ur_ifcbuildingelement
        WHEN objectclass_id = 60156 THEN
          dummy_id := citydb.del_ur_ifcbuildingelement(array_agg(object_id), 0);
        -- delete ur_ifcwindow
        WHEN objectclass_id = 60157 THEN
          dummy_id := citydb.del_ur_ifcwindow(array_agg(object_id), 0);
        -- delete ur_ifcdoor
        WHEN objectclass_id = 60158 THEN
          dummy_id := citydb.del_ur_ifcdoor(array_agg(object_id), 0);
        -- delete ur_ifcopeningelement
        WHEN objectclass_id = 60159 THEN
          dummy_id := citydb.del_ur_ifcopeningelement(array_agg(object_id), 0);
        -- delete ur_ifcelement
        WHEN objectclass_id = 60163 THEN
          dummy_id := citydb.del_ur_ifcelement(array_agg(object_id), 1);
        -- delete ur_ifcspatialstructureele
        WHEN objectclass_id = 60164 THEN
          dummy_id := citydb.del_ur_ifcspatialstructureele(array_agg(object_id), 1);
        ELSE
          dummy_id := NULL;
      END CASE;

      IF dummy_id = object_id THEN
        deleted_child_ids := array_append(deleted_child_ids, dummy_id);
      END IF;
    END LOOP;
  END IF;

  -- delete citydb.ur_ifcproducts
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_ifcproduct t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_ifcroot
    PERFORM citydb.del_ur_ifcroot(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifcproduct(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_ifcproduct(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifcproject(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_ifcunit_ids bigint[] := '{}';
  ur_ifcgeometricrepresenta_ids bigint[] := '{}';
BEGIN
  -- delete references to ur_ifcunits
  WITH del_ur_ifcunit_refs AS (
    DELETE FROM
      citydb.ur_ifcprojec_to_ifcunit t
    USING
      unnest($1) a(a_id)
    WHERE
      t.ifcproject_id = a.a_id
    RETURNING
      t.ifcunit_id
  )
  SELECT
    array_agg(ifcunit_id)
  INTO
    ur_ifcunit_ids
  FROM
    del_ur_ifcunit_refs;

  -- delete citydb.ur_ifcunit(s)
  IF -1 = ALL(ur_ifcunit_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_ifcunit(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_ifcunit_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_ifcprojects
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_ifcproject t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      representationcontexts_id
  )
  SELECT
    array_agg(id),
    array_agg(representationcontexts_id)
  INTO
    deleted_ids,
    ur_ifcgeometricrepresenta_ids
  FROM
    delete_objects;

  -- delete citydb.ur_ifcgeometricrepresenta(s)
  IF -1 = ALL(ur_ifcgeometricrepresenta_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_ifcgeometricrepresenta(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_ifcgeometricrepresenta_ids) AS a_id) a;
  END IF;

  IF $2 <> 1 THEN
    -- delete ur_ifcroot
    PERFORM citydb.del_ur_ifcroot(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifcproject(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_ifcproject(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifcprojectedcrs(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_ifcprojectedcrss
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_ifcprojectedcrs t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_ifccoordinatereference
    PERFORM citydb.del_ur_ifccoordinatereference(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifcprojectedcrs(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_ifcprojectedcrs(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifcpsetbuildingcommon(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_ifcpsetbuildingcommons
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_ifcpsetbuildingcommon t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_ifcattribute
    PERFORM citydb.del_ur_ifcattribute(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifcpsetbuildingcommon(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_ifcpsetbuildingcommon(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifcpsetdoorcommon(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_ifcpsetdoorcommons
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_ifcpsetdoorcommon t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_ifcattribute
    PERFORM citydb.del_ur_ifcattribute(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifcpsetdoorcommon(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_ifcpsetdoorcommon(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifcpsetopeningelementc(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_ifcpsetopeningelementcs
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_ifcpsetopeningelementc t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_ifcattribute
    PERFORM citydb.del_ur_ifcattribute(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifcpsetopeningelementc(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_ifcpsetopeningelementc(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifcpsetsitecommon(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_ifcpsetsitecommons
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_ifcpsetsitecommon t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_ifcattribute
    PERFORM citydb.del_ur_ifcattribute(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifcpsetsitecommon(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_ifcpsetsitecommon(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifcpsetspacecommon(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_ifcpsetspacecommons
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_ifcpsetspacecommon t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_ifcattribute
    PERFORM citydb.del_ur_ifcattribute(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifcpsetspacecommon(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_ifcpsetspacecommon(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifcpsetwindowcommon(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_ifcpsetwindowcommons
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_ifcpsetwindowcommon t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_ifcattribute
    PERFORM citydb.del_ur_ifcattribute(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifcpsetwindowcommon(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_ifcpsetwindowcommon(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifcroot(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  IF $2 <> 2 THEN
    FOR rec IN
      SELECT
        co.id, co.objectclass_id
      FROM
        citydb.cityobject co, unnest($1) a(a_id)
      WHERE
        co.id = a.a_id
    LOOP
      object_id := rec.id::bigint;
      objectclass_id := rec.objectclass_id::integer;
      CASE
        -- delete ur_ifcproduct
        WHEN objectclass_id = 60131 THEN
          dummy_id := citydb.del_ur_ifcproduct(array_agg(object_id), 1);
        -- delete ur_ifcspatialstructureele
        WHEN objectclass_id = 60132 THEN
          dummy_id := citydb.del_ur_ifcspatialstructureele(array_agg(object_id), 0);
        -- delete ur_ifcbuilding
        WHEN objectclass_id = 60133 THEN
          dummy_id := citydb.del_ur_ifcbuilding(array_agg(object_id), 0);
        -- delete ur_ifcsite
        WHEN objectclass_id = 60135 THEN
          dummy_id := citydb.del_ur_ifcsite(array_agg(object_id), 0);
        -- delete ur_ifcproject
        WHEN objectclass_id = 60137 THEN
          dummy_id := citydb.del_ur_ifcproject(array_agg(object_id), 1);
        -- delete ur_ifcspace
        WHEN objectclass_id = 60146 THEN
          dummy_id := citydb.del_ur_ifcspace(array_agg(object_id), 0);
        -- delete ur_ifcelement
        WHEN objectclass_id = 60151 THEN
          dummy_id := citydb.del_ur_ifcelement(array_agg(object_id), 0);
        -- delete ur_ifcbuildingelement
        WHEN objectclass_id = 60152 THEN
          dummy_id := citydb.del_ur_ifcbuildingelement(array_agg(object_id), 0);
        -- delete ur_ifcwall
        WHEN objectclass_id = 60153 THEN
          dummy_id := citydb.del_ur_ifcwall(array_agg(object_id), 0);
        -- delete ur_ifcwall
        WHEN objectclass_id = 60154 THEN
          dummy_id := citydb.del_ur_ifcwall(array_agg(object_id), 0);
        -- delete ur_ifcbuildingelement
        WHEN objectclass_id = 60155 THEN
          dummy_id := citydb.del_ur_ifcbuildingelement(array_agg(object_id), 0);
        -- delete ur_ifcbuildingelement
        WHEN objectclass_id = 60156 THEN
          dummy_id := citydb.del_ur_ifcbuildingelement(array_agg(object_id), 0);
        -- delete ur_ifcwindow
        WHEN objectclass_id = 60157 THEN
          dummy_id := citydb.del_ur_ifcwindow(array_agg(object_id), 0);
        -- delete ur_ifcdoor
        WHEN objectclass_id = 60158 THEN
          dummy_id := citydb.del_ur_ifcdoor(array_agg(object_id), 0);
        -- delete ur_ifcopeningelement
        WHEN objectclass_id = 60159 THEN
          dummy_id := citydb.del_ur_ifcopeningelement(array_agg(object_id), 0);
        -- delete ur_ifcelement
        WHEN objectclass_id = 60163 THEN
          dummy_id := citydb.del_ur_ifcelement(array_agg(object_id), 0);
        -- delete ur_ifcspatialstructureele
        WHEN objectclass_id = 60164 THEN
          dummy_id := citydb.del_ur_ifcspatialstructureele(array_agg(object_id), 0);
        ELSE
          dummy_id := NULL;
      END CASE;

      IF dummy_id = object_id THEN
        deleted_child_ids := array_append(deleted_child_ids, dummy_id);
      END IF;
    END LOOP;
  END IF;

  -- delete citydb.ur_ifcroots
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_ifcroot t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_ifcattribute
    PERFORM citydb.del_ur_ifcattribute(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifcroot(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_ifcroot(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifcsite(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_ifcsites
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_ifcsite t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_ifcspatialstructureele
    PERFORM citydb.del_ur_ifcspatialstructureele(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifcsite(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_ifcsite(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifcspace(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_ifcspaces
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_ifcspace t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_ifcspatialstructureele
    PERFORM citydb.del_ur_ifcspatialstructureele(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifcspace(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_ifcspace(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifcspacebasequantity(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_ifcspacebasequantitys
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_ifcspacebasequantity t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_ifcattribute
    PERFORM citydb.del_ur_ifcattribute(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifcspacebasequantity(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_ifcspacebasequantity(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifcspatialstructureele(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  IF $2 <> 2 THEN
    FOR rec IN
      SELECT
        co.id, co.objectclass_id
      FROM
        citydb.cityobject co, unnest($1) a(a_id)
      WHERE
        co.id = a.a_id
    LOOP
      object_id := rec.id::bigint;
      objectclass_id := rec.objectclass_id::integer;
      CASE
        -- delete ur_ifcbuilding
        WHEN objectclass_id = 60133 THEN
          dummy_id := citydb.del_ur_ifcbuilding(array_agg(object_id), 1);
        -- delete ur_ifcsite
        WHEN objectclass_id = 60135 THEN
          dummy_id := citydb.del_ur_ifcsite(array_agg(object_id), 1);
        -- delete ur_ifcspace
        WHEN objectclass_id = 60146 THEN
          dummy_id := citydb.del_ur_ifcspace(array_agg(object_id), 1);
        ELSE
          dummy_id := NULL;
      END CASE;

      IF dummy_id = object_id THEN
        deleted_child_ids := array_append(deleted_child_ids, dummy_id);
      END IF;
    END LOOP;
  END IF;

  -- delete citydb.ur_ifcspatialstructureeles
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_ifcspatialstructureele t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_ifcproduct
    PERFORM citydb.del_ur_ifcproduct(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifcspatialstructureele(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_ifcspatialstructureele(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifcunit(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_ifcunits
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_ifcunit t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifcunit(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_ifcunit(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifcwall(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_ifcwalls
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_ifcwall t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_ifcbuildingelement
    PERFORM citydb.del_ur_ifcbuildingelement(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifcwall(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_ifcwall(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifcwindow(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_ifcwindows
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_ifcwindow t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_ifcbuildingelement
    PERFORM citydb.del_ur_ifcbuildingelement(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ifcwindow(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_ifcwindow(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_indoorattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  IF $2 <> 2 THEN
    FOR rec IN
      SELECT
        co.id, co.objectclass_id
      FROM
        citydb.cityobject co, unnest($1) a(a_id)
      WHERE
        co.id = a.a_id
    LOOP
      object_id := rec.id::bigint;
      objectclass_id := rec.objectclass_id::integer;
      CASE
        -- delete ur_indoorspaceattribute
        WHEN objectclass_id = 60170 THEN
          dummy_id := citydb.del_ur_indoorspaceattribute(array_agg(object_id), 1);
        -- delete ur_indoorfacilityattribut
        WHEN objectclass_id = 60171 THEN
          dummy_id := citydb.del_ur_indoorfacilityattribut(array_agg(object_id), 1);
        -- delete ur_indoorstoreyattribute
        WHEN objectclass_id = 60172 THEN
          dummy_id := citydb.del_ur_indoorstoreyattribute(array_agg(object_id), 1);
        -- delete ur_indoortactiletileattri
        WHEN objectclass_id = 60173 THEN
          dummy_id := citydb.del_ur_indoortactiletileattri(array_agg(object_id), 1);
        -- delete ur_indooruserdefinedattri
        WHEN objectclass_id = 60174 THEN
          dummy_id := citydb.del_ur_indooruserdefinedattri(array_agg(object_id), 1);
        ELSE
          dummy_id := NULL;
      END CASE;

      IF dummy_id = object_id THEN
        deleted_child_ids := array_append(deleted_child_ids, dummy_id);
      END IF;
    END LOOP;
  END IF;

  -- delete citydb.ur_indoorattributes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_indoorattribute t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_indoorattribute(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_indoorattribute(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_indoorfacilityattribut(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_indoorfacilityattributs
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_indoorfacilityattribut t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_indoorattribute
    PERFORM citydb.del_ur_indoorattribute(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_indoorfacilityattribut(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_indoorfacilityattribut(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_indoorspaceattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_indoorspaceattributes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_indoorspaceattribute t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_indoorattribute
    PERFORM citydb.del_ur_indoorattribute(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_indoorspaceattribute(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_indoorspaceattribute(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_indoorstoreyattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_indoorstoreyattributes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_indoorstoreyattribute t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_indoorattribute
    PERFORM citydb.del_ur_indoorattribute(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_indoorstoreyattribute(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_indoorstoreyattribute(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_indoortactiletileattri(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_indoortactiletileattris
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_indoortactiletileattri t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_indoorattribute
    PERFORM citydb.del_ur_indoorattribute(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_indoortactiletileattri(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_indoortactiletileattri(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_indooruserdefinedattri(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_userdefinedvalue_ids bigint[] := '{}';
BEGIN
  -- delete citydb.ur_indooruserdefinedattris
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_indooruserdefinedattri t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      nominalvalue_id
  )
  SELECT
    array_agg(id),
    array_agg(nominalvalue_id)
  INTO
    deleted_ids,
    ur_userdefinedvalue_ids
  FROM
    delete_objects;

  -- delete citydb.ur_userdefinedvalue(s)
  IF -1 = ALL(ur_userdefinedvalue_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_userdefinedvalue(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_userdefinedvalue_ids) AS a_id) a;
  END IF;

  IF $2 <> 1 THEN
    -- delete ur_indoorattribute
    PERFORM citydb.del_ur_indoorattribute(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_indooruserdefinedattri(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_indooruserdefinedattri(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_industrialparkdevelopm(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_industrialparkdevelopms
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_industrialparkdevelopm t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_urbandevelopmentproj_2
    PERFORM citydb.del_ur_urbandevelopmentproj_2(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_industrialparkdevelopm(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_industrialparkdevelopm(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_itemrecordtype(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_valuebycodes_ids bigint[] := '{}';
BEGIN
  -- delete references to ur_valuebycodess
  WITH del_ur_valuebycodes_refs AS (
    DELETE FROM
      citydb.ur_itemrecor_to_valuebyco t
    USING
      unnest($1) a(a_id)
    WHERE
      t.itemrecordtype_id = a.a_id
    RETURNING
      t.valuebycodes_id
  )
  SELECT
    array_agg(valuebycodes_id)
  INTO
    ur_valuebycodes_ids
  FROM
    del_ur_valuebycodes_refs;

  -- delete citydb.ur_valuebycodes(s)
  IF -1 = ALL(ur_valuebycodes_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_valuebycodes(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_valuebycodes_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_itemrecordtypes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_itemrecordtype t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_itemrecordtype(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_itemrecordtype(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_keyvaluepair(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_keyvaluepairs
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_keyvaluepair t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_keyvaluepair(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_keyvaluepair(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_keyvaluepairattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_keyvaluepairattributes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_keyvaluepairattribute t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_keyvaluepairattribute(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_keyvaluepairattribute(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_land_use(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_dmattribute_ids bigint[] := '{}';
  ur_facilityattribute_ids bigint[] := '{}';
  ur_keyvaluepairattribute_ids bigint[] := '{}';
  ur_dataqualityattribute_ids bigint[] := '{}';
  ur_facilityidattribute_ids bigint[] := '{}';
  ur_facilitytypeattribute_ids bigint[] := '{}';
  ur_ifcattribute_ids bigint[] := '{}';
  ur_landuseattribute_ids bigint[] := '{}';
BEGIN
  -- delete references to ur_dmattributes
  WITH del_ur_dmattribute_refs AS (
    DELETE FROM
      citydb.ur_land_use_to_dmattribu t
    USING
      unnest($1) a(a_id)
    WHERE
      t.land_use_id = a.a_id
    RETURNING
      t.dmattribute_id
  )
  SELECT
    array_agg(dmattribute_id)
  INTO
    ur_dmattribute_ids
  FROM
    del_ur_dmattribute_refs;

  -- delete citydb.ur_dmattribute(s)
  IF -1 = ALL(ur_dmattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_dmattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_dmattribute_ids) AS a_id) a;
  END IF;

  -- delete references to ur_facilityattributes
  WITH del_ur_facilityattribute_refs AS (
    DELETE FROM
      citydb.ur_land_use_to_facilitya t
    USING
      unnest($1) a(a_id)
    WHERE
      t.land_use_id = a.a_id
    RETURNING
      t.facilityattribute_id
  )
  SELECT
    array_agg(facilityattribute_id)
  INTO
    ur_facilityattribute_ids
  FROM
    del_ur_facilityattribute_refs;

  -- delete citydb.ur_facilityattribute(s)
  IF -1 = ALL(ur_facilityattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_facilityattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_facilityattribute_ids) AS a_id) a;
  END IF;

  -- delete references to ur_keyvaluepairattributes
  WITH del_ur_keyvaluepairattribute_refs AS (
    DELETE FROM
      citydb.ur_land_use_to_keyvaluep t
    USING
      unnest($1) a(a_id)
    WHERE
      t.land_use_id = a.a_id
    RETURNING
      t.keyvaluepairattribute_id
  )
  SELECT
    array_agg(keyvaluepairattribute_id)
  INTO
    ur_keyvaluepairattribute_ids
  FROM
    del_ur_keyvaluepairattribute_refs;

  -- delete citydb.ur_keyvaluepairattribute(s)
  IF -1 = ALL(ur_keyvaluepairattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_keyvaluepairattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_keyvaluepairattribute_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_land_uses
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_land_use t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      lusedataqualityattribute_id,
      lusefacilityidattribute_id,
      lusefacilitytypeattribute_id,
      ifclanduseattribute_id,
      landusedetailattribute_id
  )
  SELECT
    array_agg(id),
    array_agg(lusedataqualityattribute_id),
    array_agg(lusefacilityidattribute_id),
    array_agg(lusefacilitytypeattribute_id),
    array_agg(ifclanduseattribute_id),
    array_agg(landusedetailattribute_id)
  INTO
    deleted_ids,
    ur_dataqualityattribute_ids,
    ur_facilityidattribute_ids,
    ur_facilitytypeattribute_ids,
    ur_ifcattribute_ids,
    ur_landuseattribute_ids
  FROM
    delete_objects;

  -- delete citydb.ur_dataqualityattribute(s)
  IF -1 = ALL(ur_dataqualityattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_dataqualityattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_dataqualityattribute_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_facilityidattribute(s)
  IF -1 = ALL(ur_facilityidattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_facilityidattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_facilityidattribute_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_facilitytypeattribute(s)
  IF -1 = ALL(ur_facilitytypeattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_facilitytypeattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_facilitytypeattribute_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_ifcattribute(s)
  IF -1 = ALL(ur_ifcattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_ifcattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_ifcattribute_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_landuseattribute(s)
  IF -1 = ALL(ur_landuseattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_landuseattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_landuseattribute_ids) AS a_id) a;
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_land_use(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_land_use(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_landprice(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_landpriceperlanduse_ids bigint[] := '{}';
BEGIN
  -- delete references to ur_landpriceperlanduses
  WITH del_ur_landpriceperlanduse_refs AS (
    DELETE FROM
      citydb.ur_landprice_to_landprice t
    USING
      unnest($1) a(a_id)
    WHERE
      t.landprice_id = a.a_id
    RETURNING
      t.landpriceperlanduse_id
  )
  SELECT
    array_agg(landpriceperlanduse_id)
  INTO
    ur_landpriceperlanduse_ids
  FROM
    del_ur_landpriceperlanduse_refs;

  -- delete citydb.ur_landpriceperlanduse(s)
  IF -1 = ALL(ur_landpriceperlanduse_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_landpriceperlanduse(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_landpriceperlanduse_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_landprices
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_landprice t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_statisticalgrid
    PERFORM citydb.del_ur_statisticalgrid(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_landprice(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_landprice(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_landprice_2(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  --delete ur_valuebycodess
  PERFORM
    citydb.del_ur_valuebycodes(array_agg(t.id))
  FROM
    citydb.ur_valuebycodes t,
    unnest($1) a(a_id)
  WHERE
    t.landprice_2_attributehist_id = a.a_id;

  --delete ur_valuebycodess
  PERFORM
    citydb.del_ur_valuebycodes(array_agg(t.id))
  FROM
    citydb.ur_valuebycodes t,
    unnest($1) a(a_id)
  WHERE
    t.landprice_2_landpricehist_id = a.a_id;

  -- delete citydb.ur_landprice_2s
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_landprice_2 t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_urbanfunction
    PERFORM citydb.del_ur_urbanfunction(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_landprice_2(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_landprice_2(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_landpriceperlanduse(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_landpriceperlanduses
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_landpriceperlanduse t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_landpriceperlanduse(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_landpriceperlanduse(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_landreadjustmentprojec(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_landreadjustmentprojecs
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_landreadjustmentprojec t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_urbandevelopmentproj_2
    PERFORM citydb.del_ur_urbandevelopmentproj_2(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_landreadjustmentprojec(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_landreadjustmentprojec(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_landscapezone(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_landscapezones
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_landscapezone t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_districtsandzones
    PERFORM citydb.del_ur_districtsandzones(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_landscapezone(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_landscapezone(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_landuseattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_landuseattributes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_landuseattribute t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_landuseattribute(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_landuseattribute(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_landusediversion(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_areaofannualdiversions_ids bigint[] := '{}';
  ur_numberofannualdiversio_ids bigint[] := '{}';
BEGIN
  -- delete references to ur_areaofannualdiversionss
  WITH del_ur_areaofannualdiversions_refs AS (
    DELETE FROM
      citydb.ur_landusedi_to_areaofann t
    USING
      unnest($1) a(a_id)
    WHERE
      t.landusediversion_id = a.a_id
    RETURNING
      t.areaofannualdiversions_id
  )
  SELECT
    array_agg(areaofannualdiversions_id)
  INTO
    ur_areaofannualdiversions_ids
  FROM
    del_ur_areaofannualdiversions_refs;

  -- delete citydb.ur_areaofannualdiversions(s)
  IF -1 = ALL(ur_areaofannualdiversions_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_areaofannualdiversions(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_areaofannualdiversions_ids) AS a_id) a;
  END IF;

  -- delete references to ur_numberofannualdiversios
  WITH del_ur_numberofannualdiversio_refs AS (
    DELETE FROM
      citydb.ur_landusedi_to_numberofa t
    USING
      unnest($1) a(a_id)
    WHERE
      t.landusediversion_id = a.a_id
    RETURNING
      t.numberofannualdiversio_id
  )
  SELECT
    array_agg(numberofannualdiversio_id)
  INTO
    ur_numberofannualdiversio_ids
  FROM
    del_ur_numberofannualdiversio_refs;

  -- delete citydb.ur_numberofannualdiversio(s)
  IF -1 = ALL(ur_numberofannualdiversio_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_numberofannualdiversio(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_numberofannualdiversio_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_landusediversions
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_landusediversion t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_statisticalgrid
    PERFORM citydb.del_ur_statisticalgrid(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_landusediversion(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_landusediversion(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_landusediversion_2(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_farmlandconversiontype_ids bigint[] := '{}';
  ur_forestconversiontype_ids bigint[] := '{}';
BEGIN
  -- delete citydb.ur_landusediversion_2s
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_landusediversion_2 t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      farmlandconversiontype_id,
      forestconversiontype_id
  )
  SELECT
    array_agg(id),
    array_agg(farmlandconversiontype_id),
    array_agg(forestconversiontype_id)
  INTO
    deleted_ids,
    ur_farmlandconversiontype_ids,
    ur_forestconversiontype_ids
  FROM
    delete_objects;

  -- delete citydb.ur_farmlandconversiontype(s)
  IF -1 = ALL(ur_farmlandconversiontype_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_farmlandconversiontype(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_farmlandconversiontype_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_forestconversiontype(s)
  IF -1 = ALL(ur_forestconversiontype_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_forestconversiontype(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_forestconversiontype_ids) AS a_id) a;
  END IF;

  IF $2 <> 1 THEN
    -- delete ur_urbanfunction
    PERFORM citydb.del_ur_urbanfunction(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_landusediversion_2(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_landusediversion_2(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_largecustomerfacilitya(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_largecustomerfacilityas
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_largecustomerfacilitya t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_buildingattribute
    PERFORM citydb.del_ur_buildingattribute(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_largecustomerfacilitya(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_largecustomerfacilitya(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_lengthattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_lengthattributes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_lengthattribute t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_lengthattribute(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_lengthattribute(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_longevitymeasures(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_countermeasurescost_ids bigint[] := '{}';
BEGIN
  -- delete citydb.ur_longevitymeasuress
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_longevitymeasures t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      countermeasurescost_id
  )
  SELECT
    array_agg(id),
    array_agg(countermeasurescost_id)
  INTO
    deleted_ids,
    ur_countermeasurescost_ids
  FROM
    delete_objects;

  -- delete citydb.ur_countermeasurescost(s)
  IF -1 = ALL(ur_countermeasurescost_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_countermeasurescost(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_countermeasurescost_ids) AS a_id) a;
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_longevitymeasures(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_longevitymeasures(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_maintenancehistoryattr(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_maintenancehistoryattrs
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_maintenancehistoryattr t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_facilityattribute
    PERFORM citydb.del_ur_facilityattribute(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_maintenancehistoryattr(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_maintenancehistoryattr(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_mooringfacility(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_mooringfacilitys
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_mooringfacility t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_portattribute
    PERFORM citydb.del_ur_portattribute(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_mooringfacility(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_mooringfacility(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_navigationassistancefa(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_navigationassistancefas
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_navigationassistancefa t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_portattribute
    PERFORM citydb.del_ur_portattribute(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_navigationassistancefa(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_navigationassistancefa(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_newhousing(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_newhousings
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_newhousing t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_urbanfunction
    PERFORM citydb.del_ur_urbanfunction(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_newhousing(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_newhousing(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_newhousingandurbandeve(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_newhousingandurbandeves
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_newhousingandurbandeve t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_urbandevelopmentproj_2
    PERFORM citydb.del_ur_urbandevelopmentproj_2(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_newhousingandurbandeve(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_newhousingandurbandeve(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_newurbaninfrastructure(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_newurbaninfrastructures
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_newurbaninfrastructure t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_urbandevelopmentproj_2
    PERFORM citydb.del_ur_urbandevelopmentproj_2(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_newurbaninfrastructure(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_newurbaninfrastructure(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_numberofannualdiversio(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_numberofannualdiversios
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_numberofannualdiversio t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_numberofannualdiversio(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_numberofannualdiversio(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_numberoffacilities(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_numberoffacilitiess
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_numberoffacilities t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_numberoffacilities(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_numberoffacilities(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_numberofhouseholds(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_numberofhouseholdss
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_numberofhouseholds t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_numberofhouseholds(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_numberofhouseholds(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_observationpoint(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_observationpoints
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_observationpoint t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_observationpoint(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_observationpoint(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_occupancy(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_occupancys
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_occupancy t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_occupancy(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_occupancy(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_office(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_offices
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_office t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_publictransit
    PERFORM citydb.del_ur_publictransit(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_office(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_office(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_officesandemployees(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_officesandemployeess
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_officesandemployees t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_statisticalgrid
    PERFORM citydb.del_ur_statisticalgrid(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_officesandemployees(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_officesandemployees(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_offsetdepth(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_offsetdepths
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_offsetdepth t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_offsetdepth(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_offsetdepth(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_opening(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_ifcattribute_ids bigint[] := '{}';
  ur_indoorattribute_ids bigint[] := '{}';
BEGIN
  -- delete citydb.ur_openings
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_opening t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      ifcopeningattribute_id,
      indooropeningattribute_id
  )
  SELECT
    array_agg(id),
    array_agg(ifcopeningattribute_id),
    array_agg(indooropeningattribute_id)
  INTO
    deleted_ids,
    ur_ifcattribute_ids,
    ur_indoorattribute_ids
  FROM
    delete_objects;

  -- delete citydb.ur_ifcattribute(s)
  IF -1 = ALL(ur_ifcattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_ifcattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_ifcattribute_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_indoorattribute(s)
  IF -1 = ALL(ur_indoorattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_indoorattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_indoorattribute_ids) AS a_id) a;
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_opening(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_opening(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_openspaceforpublicuse(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_parkattribute_ids bigint[] := '{}';
BEGIN
  -- delete citydb.ur_openspaceforpublicuses
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_openspaceforpublicuse t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      parkattribute_id
  )
  SELECT
    array_agg(id),
    array_agg(parkattribute_id)
  INTO
    deleted_ids,
    ur_parkattribute_ids
  FROM
    delete_objects;

  -- delete citydb.ur_parkattribute(s)
  IF -1 = ALL(ur_parkattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_parkattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_parkattribute_ids) AS a_id) a;
  END IF;

  IF $2 <> 1 THEN
    -- delete ur_urbanfacility
    PERFORM citydb.del_ur_urbanfacility(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_openspaceforpublicuse(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_openspaceforpublicuse(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_otherconstruction(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_otherconstructions
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_otherconstruction t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_construction
    PERFORM citydb.del_ur_construction(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_otherconstruction(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_otherconstruction(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_parkattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_parkattributes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_parkattribute t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_parkattribute(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_parkattribute(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_parkfacilitylongevityp(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_longevitymeasures_ids bigint[] := '{}';
  ur_parkhealthassessment_ids bigint[] := '{}';
  ur_numberoffacilities_ids bigint[] := '{}';
  ur_repairsbeforeparkhealt_ids bigint[] := '{}';
BEGIN
  -- delete references to ur_longevitymeasuress
  WITH del_ur_longevitymeasures_refs AS (
    DELETE FROM
      citydb.ur_parkfacil_to_longevity t
    USING
      unnest($1) a(a_id)
    WHERE
      t.parkfacilitylongevityp_id = a.a_id
    RETURNING
      t.longevitymeasures_id
  )
  SELECT
    array_agg(longevitymeasures_id)
  INTO
    ur_longevitymeasures_ids
  FROM
    del_ur_longevitymeasures_refs;

  -- delete citydb.ur_longevitymeasures(s)
  IF -1 = ALL(ur_longevitymeasures_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_longevitymeasures(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_longevitymeasures_ids) AS a_id) a;
  END IF;

  -- delete references to ur_parkhealthassessments
  WITH del_ur_parkhealthassessment_refs AS (
    DELETE FROM
      citydb.ur_parkfacil_to_parkhealt t
    USING
      unnest($1) a(a_id)
    WHERE
      t.parkfacilitylongevityp_id = a.a_id
    RETURNING
      t.parkhealthassessment_id
  )
  SELECT
    array_agg(parkhealthassessment_id)
  INTO
    ur_parkhealthassessment_ids
  FROM
    del_ur_parkhealthassessment_refs;

  -- delete citydb.ur_parkhealthassessment(s)
  IF -1 = ALL(ur_parkhealthassessment_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_parkhealthassessment(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_parkhealthassessment_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_parkfacilitylongevityps
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_parkfacilitylongevityp t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      numberoffacilities_id,
      repairsbeforeparkhealthas_id
  )
  SELECT
    array_agg(id),
    array_agg(numberoffacilities_id),
    array_agg(repairsbeforeparkhealthas_id)
  INTO
    deleted_ids,
    ur_numberoffacilities_ids,
    ur_repairsbeforeparkhealt_ids
  FROM
    delete_objects;

  -- delete citydb.ur_numberoffacilities(s)
  IF -1 = ALL(ur_numberoffacilities_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_numberoffacilities(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_numberoffacilities_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_repairsbeforeparkhealt(s)
  IF -1 = ALL(ur_repairsbeforeparkhealt_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_repairsbeforeparkhealt(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_repairsbeforeparkhealt_ids) AS a_id) a;
  END IF;

  IF $2 <> 1 THEN
    -- delete ur_facilityattribute
    PERFORM citydb.del_ur_facilityattribute(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_parkfacilitylongevityp(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_parkfacilitylongevityp(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_parkhealthassessment(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_parkhealthassessments
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_parkhealthassessment t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_parkhealthassessment(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_parkhealthassessment(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_parkingplaceattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_parkingplaceattributes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_parkingplaceattribute t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_parkingplaceattribute(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_parkingplaceattribute(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_pathway(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_pathways
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_pathway t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_publictransit
    PERFORM citydb.del_ur_publictransit(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_pathway(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_pathway(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_pipe(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  IF $2 <> 2 THEN
    FOR rec IN
      SELECT
        co.id, co.objectclass_id
      FROM
        citydb.cityobject co, unnest($1) a(a_id)
      WHERE
        co.id = a.a_id
    LOOP
      object_id := rec.id::bigint;
      objectclass_id := rec.objectclass_id::integer;
      CASE
        -- delete ur_sewerpipe
        WHEN objectclass_id = 60119 THEN
          dummy_id := citydb.del_ur_sewerpipe(array_agg(object_id), 1);
        ELSE
          dummy_id := NULL;
      END CASE;

      IF dummy_id = object_id THEN
        deleted_child_ids := array_append(deleted_child_ids, dummy_id);
      END IF;
    END LOOP;
  END IF;

  -- delete citydb.ur_pipes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_pipe t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_utilitylink
    PERFORM citydb.del_ur_utilitylink(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_pipe(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_pipe(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_point(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_points
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_point t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_point(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_point(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_pollution(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_observationpoint_ids bigint[] := '{}';
BEGIN
  -- delete citydb.ur_pollutions
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_pollution t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      observationpoint_id
  )
  SELECT
    array_agg(id),
    array_agg(observationpoint_id)
  INTO
    deleted_ids,
    ur_observationpoint_ids
  FROM
    delete_objects;

  -- delete citydb.ur_observationpoint(s)
  IF -1 = ALL(ur_observationpoint_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_observationpoint(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_observationpoint_ids) AS a_id) a;
  END IF;

  IF $2 <> 1 THEN
    -- delete ur_urbanfunction
    PERFORM citydb.del_ur_urbanfunction(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_pollution(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_pollution(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_population(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_populationbyageandsex_ids bigint[] := '{}';
BEGIN
  -- delete references to ur_populationbyageandsexs
  WITH del_ur_populationbyageandsex_refs AS (
    DELETE FROM
      citydb.ur_populatio_to_populatio t
    USING
      unnest($1) a(a_id)
    WHERE
      t.population_id = a.a_id
    RETURNING
      t.populationbyageandsex_id
  )
  SELECT
    array_agg(populationbyageandsex_id)
  INTO
    ur_populationbyageandsex_ids
  FROM
    del_ur_populationbyageandsex_refs;

  -- delete citydb.ur_populationbyageandsex(s)
  IF -1 = ALL(ur_populationbyageandsex_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_populationbyageandsex(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_populationbyageandsex_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_populations
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_population t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_statisticalgrid
    PERFORM citydb.del_ur_statisticalgrid(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_population(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_population(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_populationbyageandsex(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_populationbyageandsexs
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_populationbyageandsex t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_populationbyageandsex(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_populationbyageandsex(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_populationbyageandsext(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_populationbyageandsexts
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_populationbyageandsext t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_populationbyageandsext(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_populationbyageandsext(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_populationtype(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_populationbyageandsext_ids bigint[] := '{}';
BEGIN
  -- delete references to ur_populationbyageandsexts
  WITH del_ur_populationbyageandsext_refs AS (
    DELETE FROM
      citydb.ur_populatio_to_populat_2 t
    USING
      unnest($1) a(a_id)
    WHERE
      t.populationtype_id = a.a_id
    RETURNING
      t.populationbyageandsext_id
  )
  SELECT
    array_agg(populationbyageandsext_id)
  INTO
    ur_populationbyageandsext_ids
  FROM
    del_ur_populationbyageandsext_refs;

  -- delete citydb.ur_populationbyageandsext(s)
  IF -1 = ALL(ur_populationbyageandsext_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_populationbyageandsext(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_populationbyageandsext_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_populationtypes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_populationtype t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_populationtype(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_populationtype(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_portattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  IF $2 <> 2 THEN
    FOR rec IN
      SELECT
        co.id, co.objectclass_id
      FROM
        citydb.cityobject co, unnest($1) a(a_id)
      WHERE
        co.id = a.a_id
    LOOP
      object_id := rec.id::bigint;
      objectclass_id := rec.objectclass_id::integer;
      CASE
        -- delete ur_harborfacility
        WHEN objectclass_id = 60063 THEN
          dummy_id := citydb.del_ur_harborfacility(array_agg(object_id), 1);
        -- delete ur_portprotectivefacility
        WHEN objectclass_id = 60064 THEN
          dummy_id := citydb.del_ur_portprotectivefacility(array_agg(object_id), 1);
        -- delete ur_mooringfacility
        WHEN objectclass_id = 60065 THEN
          dummy_id := citydb.del_ur_mooringfacility(array_agg(object_id), 1);
        -- delete ur_porttransportationfaci
        WHEN objectclass_id = 60066 THEN
          dummy_id := citydb.del_ur_porttransportationfaci(array_agg(object_id), 1);
        -- delete ur_navigationassistancefa
        WHEN objectclass_id = 60067 THEN
          dummy_id := citydb.del_ur_navigationassistancefa(array_agg(object_id), 1);
        -- delete ur_cargohandlingfacility
        WHEN objectclass_id = 60068 THEN
          dummy_id := citydb.del_ur_cargohandlingfacility(array_agg(object_id), 1);
        -- delete ur_portpassengerfacility
        WHEN objectclass_id = 60069 THEN
          dummy_id := citydb.del_ur_portpassengerfacility(array_agg(object_id), 1);
        -- delete ur_portstoragefacility
        WHEN objectclass_id = 60070 THEN
          dummy_id := citydb.del_ur_portstoragefacility(array_agg(object_id), 1);
        -- delete ur_shipservicefacility
        WHEN objectclass_id = 60071 THEN
          dummy_id := citydb.del_ur_shipservicefacility(array_agg(object_id), 1);
        -- delete ur_portwastetreatmentfaci
        WHEN objectclass_id = 60072 THEN
          dummy_id := citydb.del_ur_portwastetreatmentfaci(array_agg(object_id), 1);
        -- delete ur_portenvironmentalimpro
        WHEN objectclass_id = 60073 THEN
          dummy_id := citydb.del_ur_portenvironmentalimpro(array_agg(object_id), 1);
        -- delete ur_portpollutioncontrolfa
        WHEN objectclass_id = 60074 THEN
          dummy_id := citydb.del_ur_portpollutioncontrolfa(array_agg(object_id), 1);
        -- delete ur_portwelfarefacility
        WHEN objectclass_id = 60075 THEN
          dummy_id := citydb.del_ur_portwelfarefacility(array_agg(object_id), 1);
        -- delete ur_portmanagementfacility
        WHEN objectclass_id = 60076 THEN
          dummy_id := citydb.del_ur_portmanagementfacility(array_agg(object_id), 1);
        -- delete ur_cyberportmarinaandpbs
        WHEN objectclass_id = 60077 THEN
          dummy_id := citydb.del_ur_cyberportmarinaandpbs(array_agg(object_id), 1);
        ELSE
          dummy_id := NULL;
      END CASE;

      IF dummy_id = object_id THEN
        deleted_child_ids := array_append(deleted_child_ids, dummy_id);
      END IF;
    END LOOP;
  END IF;

  -- delete citydb.ur_portattributes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_portattribute t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_facilityattribute
    PERFORM citydb.del_ur_facilityattribute(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_portattribute(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_portattribute(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_portenvironmentalimpro(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_portenvironmentalimpros
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_portenvironmentalimpro t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_portattribute
    PERFORM citydb.del_ur_portattribute(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_portenvironmentalimpro(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_portenvironmentalimpro(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_portmanagementfacility(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_portmanagementfacilitys
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_portmanagementfacility t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_portattribute
    PERFORM citydb.del_ur_portattribute(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_portmanagementfacility(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_portmanagementfacility(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_portpassengerfacility(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_portpassengerfacilitys
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_portpassengerfacility t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_portattribute
    PERFORM citydb.del_ur_portattribute(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_portpassengerfacility(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_portpassengerfacility(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_portpollutioncontrolfa(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_portpollutioncontrolfas
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_portpollutioncontrolfa t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_portattribute
    PERFORM citydb.del_ur_portattribute(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_portpollutioncontrolfa(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_portpollutioncontrolfa(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_portprotectivefacility(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_portprotectivefacilitys
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_portprotectivefacility t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_portattribute
    PERFORM citydb.del_ur_portattribute(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_portprotectivefacility(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_portprotectivefacility(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_portstoragefacility(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_portstoragefacilitys
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_portstoragefacility t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_portattribute
    PERFORM citydb.del_ur_portattribute(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_portstoragefacility(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_portstoragefacility(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_porttransportationfaci(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_porttransportationfacis
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_porttransportationfaci t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_portattribute
    PERFORM citydb.del_ur_portattribute(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_porttransportationfaci(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_porttransportationfaci(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_portwastetreatmentfaci(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_portwastetreatmentfacis
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_portwastetreatmentfaci t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_portattribute
    PERFORM citydb.del_ur_portattribute(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_portwastetreatmentfaci(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_portwastetreatmentfaci(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_portwelfarefacility(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_portwelfarefacilitys
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_portwelfarefacility t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_portattribute
    PERFORM citydb.del_ur_portattribute(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_portwelfarefacility(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_portwelfarefacility(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_portzone(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_portzones
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_portzone t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_districtsandzones
    PERFORM citydb.del_ur_districtsandzones(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_portzone(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_portzone(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_privateurbanrenewalpro(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_privateurbanrenewalpros
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_privateurbanrenewalpro t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_zone
    PERFORM citydb.del_ur_zone(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_privateurbanrenewalpro(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_privateurbanrenewalpro(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_productivegreenzone(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_productivegreenzones
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_productivegreenzone t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_districtsandzones
    PERFORM citydb.del_ur_districtsandzones(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_productivegreenzone(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_productivegreenzone(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_projectpromotionarea(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  IF $2 <> 2 THEN
    FOR rec IN
      SELECT
        co.id, co.objectclass_id
      FROM
        citydb.cityobject co, unnest($1) a(a_id)
      WHERE
        co.id = a.a_id
    LOOP
      object_id := rec.id::bigint;
      objectclass_id := rec.objectclass_id::integer;
      CASE
        -- delete ur_urbanredevelopmentprom
        WHEN objectclass_id = 60336 THEN
          dummy_id := citydb.del_ur_urbanredevelopmentprom(array_agg(object_id), 1);
        ELSE
          dummy_id := NULL;
      END CASE;

      IF dummy_id = object_id THEN
        deleted_child_ids := array_append(deleted_child_ids, dummy_id);
      END IF;
    END LOOP;
  END IF;

  -- delete citydb.ur_projectpromotionareas
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_projectpromotionarea t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_zone
    PERFORM citydb.del_ur_zone(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_projectpromotionarea(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_projectpromotionarea(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_publicland(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_publiclands
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_publicland t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete land_use
    PERFORM citydb.del_land_use(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_publicland(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_publicland(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_publicsurveydataqualit(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_publicsurveydataqualits
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_publicsurveydataqualit t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_publicsurveydataqualit(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_publicsurveydataqualit(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_publictransit(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_point_ids bigint[] := '{}';
BEGIN
  -- delete references to ur_points
  WITH del_ur_point_refs AS (
    DELETE FROM
      citydb.ur_publictra_to_point t
    USING
      unnest($1) a(a_id)
    WHERE
      t.publictransit_id = a.a_id
    RETURNING
      t.point_id
  )
  SELECT
    array_agg(point_id)
  INTO
    ur_point_ids
  FROM
    del_ur_point_refs;

  -- delete citydb.ur_point(s)
  IF -1 = ALL(ur_point_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_point(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_point_ids) AS a_id) a;
  END IF;

  IF $2 <> 2 THEN
    FOR rec IN
      SELECT
        co.id, co.objectclass_id
      FROM
        citydb.cityobject co, unnest($1) a(a_id)
      WHERE
        co.id = a.a_id
    LOOP
      object_id := rec.id::bigint;
      objectclass_id := rec.objectclass_id::integer;
      CASE
        -- delete ur_route
        WHEN objectclass_id = 60208 THEN
          dummy_id := citydb.del_ur_route(array_agg(object_id), 1);
        -- delete ur_agency
        WHEN objectclass_id = 60210 THEN
          dummy_id := citydb.del_ur_agency(array_agg(object_id), 1);
        -- delete ur_stop
        WHEN objectclass_id = 60211 THEN
          dummy_id := citydb.del_ur_stop(array_agg(object_id), 1);
        -- delete ur_trip
        WHEN objectclass_id = 60213 THEN
          dummy_id := citydb.del_ur_trip(array_agg(object_id), 1);
        -- delete ur_calendar
        WHEN objectclass_id = 60214 THEN
          dummy_id := citydb.del_ur_calendar(array_agg(object_id), 1);
        -- delete ur_calendardate
        WHEN objectclass_id = 60215 THEN
          dummy_id := citydb.del_ur_calendardate(array_agg(object_id), 1);
        -- delete ur_office
        WHEN objectclass_id = 60216 THEN
          dummy_id := citydb.del_ur_office(array_agg(object_id), 1);
        -- delete ur_fareattribute
        WHEN objectclass_id = 60219 THEN
          dummy_id := citydb.del_ur_fareattribute(array_agg(object_id), 1);
        -- delete ur_pathway
        WHEN objectclass_id = 60220 THEN
          dummy_id := citydb.del_ur_pathway(array_agg(object_id), 1);
        -- delete ur_translationjp
        WHEN objectclass_id = 60221 THEN
          dummy_id := citydb.del_ur_translationjp(array_agg(object_id), 1);
        -- delete ur_attribution
        WHEN objectclass_id = 60222 THEN
          dummy_id := citydb.del_ur_attribution(array_agg(object_id), 1);
        ELSE
          dummy_id := NULL;
      END CASE;

      IF dummy_id = object_id THEN
        deleted_child_ids := array_append(deleted_child_ids, dummy_id);
      END IF;
    END LOOP;
  END IF;

  -- delete citydb.ur_publictransits
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_publictransit t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete cityobject
    PERFORM citydb.del_cityobject(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_publictransit(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_publictransit(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_publictransitdatatype(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  IF $2 <> 2 THEN
    FOR rec IN
      SELECT
        co.id, co.objectclass_id
      FROM
        citydb.cityobject co, unnest($1) a(a_id)
      WHERE
        co.id = a.a_id
    LOOP
      object_id := rec.id::bigint;
      objectclass_id := rec.objectclass_id::integer;
      CASE
        -- delete ur_feedinfo
        WHEN objectclass_id = 60224 THEN
          dummy_id := citydb.del_ur_feedinfo(array_agg(object_id), 1);
        -- delete ur_translation
        WHEN objectclass_id = 60225 THEN
          dummy_id := citydb.del_ur_translation(array_agg(object_id), 1);
        -- delete ur_transfer
        WHEN objectclass_id = 60226 THEN
          dummy_id := citydb.del_ur_transfer(array_agg(object_id), 1);
        -- delete ur_frequency
        WHEN objectclass_id = 60227 THEN
          dummy_id := citydb.del_ur_frequency(array_agg(object_id), 1);
        -- delete ur_stoptime
        WHEN objectclass_id = 60228 THEN
          dummy_id := citydb.del_ur_stoptime(array_agg(object_id), 1);
        -- delete ur_farerule
        WHEN objectclass_id = 60229 THEN
          dummy_id := citydb.del_ur_farerule(array_agg(object_id), 1);
        ELSE
          dummy_id := NULL;
      END CASE;

      IF dummy_id = object_id THEN
        deleted_child_ids := array_append(deleted_child_ids, dummy_id);
      END IF;
    END LOOP;
  END IF;

  -- delete citydb.ur_publictransitdatatypes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_publictransitdatatype t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_publictransitdatatype(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_publictransitdatatype(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_publictransitfacility(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_publictransitfacilitys
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_publictransitfacility t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_urbanfunction
    PERFORM citydb.del_ur_urbanfunction(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_publictransitfacility(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_publictransitfacility(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_quasiurbanplanningarea(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_quasiurbanplanningareas
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_quasiurbanplanningarea t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_zone
    PERFORM citydb.del_ur_zone(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_quasiurbanplanningarea(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_quasiurbanplanningarea(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_railwayrouteattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_railwayrouteattributes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_railwayrouteattribute t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_railwayrouteattribute(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_railwayrouteattribute(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_railwaytrackattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_controlpoint_ids bigint[] := '{}';
  surface_geometry_ids bigint[] := '{}';
BEGIN
  -- delete references to ur_controlpoints
  WITH del_ur_controlpoint_refs AS (
    DELETE FROM
      citydb.ur_railwaytr_to_controlpo t
    USING
      unnest($1) a(a_id)
    WHERE
      t.railwaytrackattribute_id = a.a_id
    RETURNING
      t.controlpoint_id
  )
  SELECT
    array_agg(controlpoint_id)
  INTO
    ur_controlpoint_ids
  FROM
    del_ur_controlpoint_refs;

  -- delete citydb.ur_controlpoint(s)
  IF -1 = ALL(ur_controlpoint_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_controlpoint(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_controlpoint_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_railwaytrackattributes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_railwaytrackattribute t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      lod2network_brep_id,
      lod3network_brep_id
  )
  SELECT
    array_agg(id),
    array_agg(lod2network_brep_id) ||
    array_agg(lod3network_brep_id)
  INTO
    deleted_ids,
    surface_geometry_ids
  FROM
    delete_objects;

  -- delete citydb.surface_geometry(s)
  IF -1 = ALL(surface_geometry_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_surface_geometry(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(surface_geometry_ids) AS a_id) a;
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_railwaytrackattribute(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_railwaytrackattribute(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_realestateidattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_realestateidattributes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_realestateidattribute t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_buildingattribute
    PERFORM citydb.del_ur_buildingattribute(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_realestateidattribute(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_realestateidattribute(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_recreations(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_recreationss
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_recreations t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_urbanfunction
    PERFORM citydb.del_ur_urbanfunction(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_recreations(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_recreations(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_relief_component(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_dmattribute_ids bigint[] := '{}';
BEGIN
  -- delete references to ur_dmattributes
  WITH del_ur_dmattribute_refs AS (
    DELETE FROM
      citydb.ur_relief_co_to_dmattribu t
    USING
      unnest($1) a(a_id)
    WHERE
      t.relief_component_id = a.a_id
    RETURNING
      t.dmattribute_id
  )
  SELECT
    array_agg(dmattribute_id)
  INTO
    ur_dmattribute_ids
  FROM
    del_ur_dmattribute_refs;

  -- delete citydb.ur_dmattribute(s)
  IF -1 = ALL(ur_dmattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_dmattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_dmattribute_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_relief_components
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_relief_component t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_relief_component(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_relief_component(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_relief_feature(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_keyvaluepairattribute_ids bigint[] := '{}';
  ur_dataqualityattribute_ids bigint[] := '{}';
BEGIN
  -- delete references to ur_keyvaluepairattributes
  WITH del_ur_keyvaluepairattribute_refs AS (
    DELETE FROM
      citydb.ur_relief_fe_to_keyvaluep t
    USING
      unnest($1) a(a_id)
    WHERE
      t.relief_feature_id = a.a_id
    RETURNING
      t.keyvaluepairattribute_id
  )
  SELECT
    array_agg(keyvaluepairattribute_id)
  INTO
    ur_keyvaluepairattribute_ids
  FROM
    del_ur_keyvaluepairattribute_refs;

  -- delete citydb.ur_keyvaluepairattribute(s)
  IF -1 = ALL(ur_keyvaluepairattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_keyvaluepairattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_keyvaluepairattribute_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_relief_features
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_relief_feature t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      demdataqualityattribute_id
  )
  SELECT
    array_agg(id),
    array_agg(demdataqualityattribute_id)
  INTO
    deleted_ids,
    ur_dataqualityattribute_ids
  FROM
    delete_objects;

  -- delete citydb.ur_dataqualityattribute(s)
  IF -1 = ALL(ur_dataqualityattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_dataqualityattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_dataqualityattribute_ids) AS a_id) a;
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_relief_feature(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_relief_feature(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_repairsbeforeparkhealt(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_repairsbeforeparkhealts
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_repairsbeforeparkhealt t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_repairsbeforeparkhealt(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_repairsbeforeparkhealt(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_residentialblockconstr(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_residentialblockconstrs
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_residentialblockconstr t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_urbandevelopmentproj_2
    PERFORM citydb.del_ur_urbandevelopmentproj_2(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_residentialblockconstr(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_residentialblockconstr(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_residentialdevelopment(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_residentialdevelopments
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_residentialdevelopment t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_residentialdevelopment(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_residentialdevelopment(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_residentialenvironment(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_residentialenvironments
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_residentialenvironment t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_districtsandzones
    PERFORM citydb.del_ur_districtsandzones(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_residentialenvironment(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_residentialenvironment(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_riverfacilityidattribu(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_riverfacilityidattribus
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_riverfacilityidattribu t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_facilityidattribute
    PERFORM citydb.del_ur_facilityidattribute(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_riverfacilityidattribu(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_riverfacilityidattribu(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_riverfloodingriskattri(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_riverfloodingriskattris
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_riverfloodingriskattri t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_floodingriskattribute
    PERFORM citydb.del_ur_floodingriskattribute(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_riverfloodingriskattri(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_riverfloodingriskattri(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_roadattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  IF $2 <> 2 THEN
    FOR rec IN
      SELECT
        co.id, co.objectclass_id
      FROM
        citydb.cityobject co, unnest($1) a(a_id)
      WHERE
        co.id = a.a_id
    LOOP
      object_id := rec.id::bigint;
      objectclass_id := rec.objectclass_id::integer;
      CASE
        -- delete ur_trafficvolumeattribute
        WHEN objectclass_id = 60040 THEN
          dummy_id := citydb.del_ur_trafficvolumeattribute(array_agg(object_id), 1);
        -- delete ur_roadstructureattribute
        WHEN objectclass_id = 60041 THEN
          dummy_id := citydb.del_ur_roadstructureattribute(array_agg(object_id), 1);
        ELSE
          dummy_id := NULL;
      END CASE;

      IF dummy_id = object_id THEN
        deleted_child_ids := array_append(deleted_child_ids, dummy_id);
      END IF;
    END LOOP;
  END IF;

  -- delete citydb.ur_roadattributes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_roadattribute t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_roadattribute(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_roadattribute(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_roadsidedistrictimprov(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_roadsidedistrictimprovs
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_roadsidedistrictimprov t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_districtdevelopmentpla
    PERFORM citydb.del_ur_districtdevelopmentpla(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_roadsidedistrictimprov(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_roadsidedistrictimprov(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_roadsidedistrictplan(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_roadsidedistrictplans
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_roadsidedistrictplan t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_abstractdistrictplan
    PERFORM citydb.del_ur_abstractdistrictplan(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_roadsidedistrictplan(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_roadsidedistrictplan(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_roadstructureattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_roadstructureattributes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_roadstructureattribute t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_roadattribute
    PERFORM citydb.del_ur_roadattribute(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_roadstructureattribute(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_roadstructureattribute(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_roadtype(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_roadtypes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_roadtype t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_roadtype(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_roadtype(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_room(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_ifcattribute_ids bigint[] := '{}';
  ur_indoorattribute_ids bigint[] := '{}';
BEGIN
  -- delete citydb.ur_rooms
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_room t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      ifcroomattribute_id,
      indoorroomattribute_id
  )
  SELECT
    array_agg(id),
    array_agg(ifcroomattribute_id),
    array_agg(indoorroomattribute_id)
  INTO
    deleted_ids,
    ur_ifcattribute_ids,
    ur_indoorattribute_ids
  FROM
    delete_objects;

  -- delete citydb.ur_ifcattribute(s)
  IF -1 = ALL(ur_ifcattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_ifcattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_ifcattribute_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_indoorattribute(s)
  IF -1 = ALL(ur_indoorattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_indoorattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_indoorattribute_ids) AS a_id) a;
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_room(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_room(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_route(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_description_ids bigint[] := '{}';
BEGIN
  -- delete citydb.ur_routes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_route t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      description_id
  )
  SELECT
    array_agg(id),
    array_agg(description_id)
  INTO
    deleted_ids,
    ur_description_ids
  FROM
    delete_objects;

  -- delete citydb.ur_description(s)
  IF -1 = ALL(ur_description_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_description(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_description_ids) AS a_id) a;
  END IF;

  IF $2 <> 1 THEN
    -- delete ur_publictransit
    PERFORM citydb.del_ur_publictransit(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_route(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_route(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ruraldistrictimproveme(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_ruraldistrictimprovemes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_ruraldistrictimproveme t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_districtdevelopmentpla
    PERFORM citydb.del_ur_districtdevelopmentpla(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_ruraldistrictimproveme(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_ruraldistrictimproveme(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_scenicdistrict(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_scenicdistricts
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_scenicdistrict t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_districtsandzones
    PERFORM citydb.del_ur_districtsandzones(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_scenicdistrict(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_scenicdistrict(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_scenicresource(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_scenicresources
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_scenicresource t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_urbanfunction
    PERFORM citydb.del_ur_urbanfunction(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_scenicresource(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_scenicresource(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_scheduledareaforurband(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_scheduledareaforurbands
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_scheduledareaforurband t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_zone
    PERFORM citydb.del_ur_zone(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_scheduledareaforurband(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_scheduledareaforurband(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_sedimentdisasterpronea(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_sedimentdisasterproneas
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_sedimentdisasterpronea t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_zone
    PERFORM citydb.del_ur_zone(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_sedimentdisasterpronea(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_sedimentdisasterpronea(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_sewerpipe(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_sewerpipes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_sewerpipe t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_pipe
    PERFORM citydb.del_ur_pipe(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_sewerpipe(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_sewerpipe(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_sewersystemattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_sewersystemattributes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_sewersystemattribute t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_sewersystemattribute(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_sewersystemattribute(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_shipservicefacility(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_shipservicefacilitys
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_shipservicefacility t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_portattribute
    PERFORM citydb.del_ur_portattribute(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_shipservicefacility(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_shipservicefacility(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_slopetype(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_slopetypes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_slopetype t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_slopetype(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_slopetype(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_specialgreenspaceconse(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_specialgreenspaceconses
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_specialgreenspaceconse t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_districtsandzones
    PERFORM citydb.del_ur_districtsandzones(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_specialgreenspaceconse(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_specialgreenspaceconse(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_specialurbanrenaissanc(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_specialurbanrenaissancs
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_specialurbanrenaissanc t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_districtsandzones
    PERFORM citydb.del_ur_districtsandzones(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_specialurbanrenaissanc(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_specialurbanrenaissanc(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_specialuseattractiondi(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_specialuseattractiondis
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_specialuseattractiondi t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_districtsandzones
    PERFORM citydb.del_ur_districtsandzones(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_specialuseattractiondi(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_specialuseattractiondi(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_specialusedistrict(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_specialusedistricts
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_specialusedistrict t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_districtsandzones
    PERFORM citydb.del_ur_districtsandzones(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_specialusedistrict(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_specialusedistrict(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_specialuserestrictiond(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_specialuserestrictionds
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_specialuserestrictiond t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_districtsandzones
    PERFORM citydb.del_ur_districtsandzones(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_specialuserestrictiond(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_specialuserestrictiond(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_specifiedblock(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_specifiedblocks
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_specifiedblock t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_districtsandzones
    PERFORM citydb.del_ur_districtsandzones(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_specifiedblock(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_specifiedblock(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_specifieddisasterpreve(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_specifieddisasterpreves
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_specifieddisasterpreve t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_districtsandzones
    PERFORM citydb.del_ur_districtsandzones(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_specifieddisasterpreve(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_specifieddisasterpreve(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_specifiedurgenturbanre(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_specifiedurgenturbanres
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_specifiedurgenturbanre t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_urgenturbanrenewalarea
    PERFORM citydb.del_ur_urgenturbanrenewalarea(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_specifiedurgenturbanre(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_specifiedurgenturbanre(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_squareurbanplanattribu(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  IF $2 <> 2 THEN
    FOR rec IN
      SELECT
        co.id, co.objectclass_id
      FROM
        citydb.cityobject co, unnest($1) a(a_id)
      WHERE
        co.id = a.a_id
    LOOP
      object_id := rec.id::bigint;
      objectclass_id := rec.objectclass_id::integer;
      CASE
        -- delete ur_stationsquareattribute
        WHEN objectclass_id = 60106 THEN
          dummy_id := citydb.del_ur_stationsquareattribute(array_agg(object_id), 1);
        -- delete ur_terminalattribute
        WHEN objectclass_id = 60107 THEN
          dummy_id := citydb.del_ur_terminalattribute(array_agg(object_id), 1);
        ELSE
          dummy_id := NULL;
      END CASE;

      IF dummy_id = object_id THEN
        deleted_child_ids := array_append(deleted_child_ids, dummy_id);
      END IF;
    END LOOP;
  END IF;

  -- delete citydb.ur_squareurbanplanattribus
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_squareurbanplanattribu t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_squareurbanplanattribu(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_squareurbanplanattribu(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_stationsquareattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_stationsquareattributes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_stationsquareattribute t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_squareurbanplanattribu
    PERFORM citydb.del_ur_squareurbanplanattribu(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_stationsquareattribute(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_stationsquareattribute(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_statisticalgrid(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_keyvaluepair_ids bigint[] := '{}';
  surface_geometry_ids bigint[] := '{}';
BEGIN
  -- delete references to ur_keyvaluepairs
  WITH del_ur_keyvaluepair_refs AS (
    DELETE FROM
      citydb.ur_statistic_to_keyvaluep t
    USING
      unnest($1) a(a_id)
    WHERE
      t.statisticalgrid_id = a.a_id
    RETURNING
      t.keyvaluepair_id
  )
  SELECT
    array_agg(keyvaluepair_id)
  INTO
    ur_keyvaluepair_ids
  FROM
    del_ur_keyvaluepair_refs;

  -- delete citydb.ur_keyvaluepair(s)
  IF -1 = ALL(ur_keyvaluepair_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_keyvaluepair(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_keyvaluepair_ids) AS a_id) a;
  END IF;

  IF $2 <> 2 THEN
    FOR rec IN
      SELECT
        co.id, co.objectclass_id
      FROM
        citydb.cityobject co, unnest($1) a(a_id)
      WHERE
        co.id = a.a_id
    LOOP
      object_id := rec.id::bigint;
      objectclass_id := rec.objectclass_id::integer;
      CASE
        -- delete ur_population
        WHEN objectclass_id = 60001 THEN
          dummy_id := citydb.del_ur_population(array_agg(object_id), 1);
        -- delete ur_landprice
        WHEN objectclass_id = 60004 THEN
          dummy_id := citydb.del_ur_landprice(array_agg(object_id), 1);
        -- delete ur_landusediversion
        WHEN objectclass_id = 60006 THEN
          dummy_id := citydb.del_ur_landusediversion(array_agg(object_id), 1);
        -- delete ur_households
        WHEN objectclass_id = 60009 THEN
          dummy_id := citydb.del_ur_households(array_agg(object_id), 1);
        -- delete ur_officesandemployees
        WHEN objectclass_id = 60011 THEN
          dummy_id := citydb.del_ur_officesandemployees(array_agg(object_id), 1);
        ELSE
          dummy_id := NULL;
      END CASE;

      IF dummy_id = object_id THEN
        deleted_child_ids := array_append(deleted_child_ids, dummy_id);
      END IF;
    END LOOP;
  END IF;

  -- delete citydb.ur_statisticalgrids
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_statisticalgrid t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      lod_1multisurface_id,
      lod_2multisurface_id
  )
  SELECT
    array_agg(id),
    array_agg(lod_1multisurface_id) ||
    array_agg(lod_2multisurface_id)
  INTO
    deleted_ids,
    surface_geometry_ids
  FROM
    delete_objects;

  -- delete citydb.surface_geometry(s)
  IF -1 = ALL(surface_geometry_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_surface_geometry(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(surface_geometry_ids) AS a_id) a;
  END IF;

  IF $2 <> 1 THEN
    -- delete cityobject
    PERFORM citydb.del_cityobject(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_statisticalgrid(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_statisticalgrid(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_stop(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_stops
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_stop t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_publictransit
    PERFORM citydb.del_ur_publictransit(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_stop(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_stop(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_stoptime(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_stoptimes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_stoptime t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_publictransitdatatype
    PERFORM citydb.del_ur_publictransitdatatype(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_stoptime(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_stoptime(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_structuredetails(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_structuredetailss
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_structuredetails t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_structuredetails(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_structuredetails(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_summaryrecordtype(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_valuebycodes_ids bigint[] := '{}';
BEGIN
  -- delete references to ur_valuebycodess
  WITH del_ur_valuebycodes_refs AS (
    DELETE FROM
      citydb.ur_summaryre_to_valuebyco t
    USING
      unnest($1) a(a_id)
    WHERE
      t.summaryrecordtype_id = a.a_id
    RETURNING
      t.valuebycodes_id
  )
  SELECT
    array_agg(valuebycodes_id)
  INTO
    ur_valuebycodes_ids
  FROM
    del_ur_valuebycodes_refs;

  -- delete citydb.ur_valuebycodes(s)
  IF -1 = ALL(ur_valuebycodes_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_valuebycodes(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_valuebycodes_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_summaryrecordtypes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_summaryrecordtype t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_summaryrecordtype(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_summaryrecordtype(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_supplyfacility(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_waterworksattribute_ids bigint[] := '{}';
BEGIN
  -- delete citydb.ur_supplyfacilitys
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_supplyfacility t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      waterworksattribute_id
  )
  SELECT
    array_agg(id),
    array_agg(waterworksattribute_id)
  INTO
    deleted_ids,
    ur_waterworksattribute_ids
  FROM
    delete_objects;

  -- delete citydb.ur_waterworksattribute(s)
  IF -1 = ALL(ur_waterworksattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_waterworksattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_waterworksattribute_ids) AS a_id) a;
  END IF;

  IF $2 <> 1 THEN
    -- delete ur_urbanfacility
    PERFORM citydb.del_ur_urbanfacility(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_supplyfacility(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_supplyfacility(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_terminalattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_terminalattributes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_terminalattribute t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_squareurbanplanattribu
    PERFORM citydb.del_ur_squareurbanplanattribu(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_terminalattribute(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_terminalattribute(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_thematic_surface(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_ifcattribute_ids bigint[] := '{}';
  ur_indoorattribute_ids bigint[] := '{}';
BEGIN
  -- delete citydb.ur_thematic_surfaces
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_thematic_surface t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      ifcboundarysurfaceattribu_id,
      indoorboundarysurfaceattr_id
  )
  SELECT
    array_agg(id),
    array_agg(ifcboundarysurfaceattribu_id),
    array_agg(indoorboundarysurfaceattr_id)
  INTO
    deleted_ids,
    ur_ifcattribute_ids,
    ur_indoorattribute_ids
  FROM
    delete_objects;

  -- delete citydb.ur_ifcattribute(s)
  IF -1 = ALL(ur_ifcattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_ifcattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_ifcattribute_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_indoorattribute(s)
  IF -1 = ALL(ur_indoorattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_indoorattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_indoorattribute_ids) AS a_id) a;
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_thematic_surface(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_thematic_surface(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_thematicshape(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  surface_geometry_ids bigint[] := '{}';
BEGIN
  -- delete citydb.ur_thematicshapes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_thematicshape t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      shape_brep_id
  )
  SELECT
    array_agg(id),
    array_agg(shape_brep_id)
  INTO
    deleted_ids,
    surface_geometry_ids
  FROM
    delete_objects;

  -- delete citydb.surface_geometry(s)
  IF -1 = ALL(surface_geometry_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_surface_geometry(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(surface_geometry_ids) AS a_id) a;
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_thematicshape(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_thematicshape(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_threedimensionalextent(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_threedimensionalextents
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_threedimensionalextent t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_urbanfunction
    PERFORM citydb.del_ur_urbanfunction(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_threedimensionalextent(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_threedimensionalextent(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_trackattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_trackattributes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_trackattribute t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_trackattribute(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_trackattribute(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_traffic_area(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_railwaytrackattribute_ids bigint[] := '{}';
  ur_trafficareaattribute_ids bigint[] := '{}';
BEGIN
  -- delete citydb.ur_traffic_areas
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_traffic_area t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      railwaytrackattribute_id,
      trafficareastructureattri_id
  )
  SELECT
    array_agg(id),
    array_agg(railwaytrackattribute_id),
    array_agg(trafficareastructureattri_id)
  INTO
    deleted_ids,
    ur_railwaytrackattribute_ids,
    ur_trafficareaattribute_ids
  FROM
    delete_objects;

  -- delete citydb.ur_railwaytrackattribute(s)
  IF -1 = ALL(ur_railwaytrackattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_railwaytrackattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_railwaytrackattribute_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_trafficareaattribute(s)
  IF -1 = ALL(ur_trafficareaattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_trafficareaattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_trafficareaattribute_ids) AS a_id) a;
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_traffic_area(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_traffic_area(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_trafficareaattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_trafficareaattributes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_trafficareaattribute t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_trafficareaattribute(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_trafficareaattribute(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_trafficfacility(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_parkingplaceattribute_ids bigint[] := '{}';
  ur_urbanrapidtransitrailr_ids bigint[] := '{}';
  ur_urbanroadattribute_ids bigint[] := '{}';
  ur_vehicleterminalattribu_ids bigint[] := '{}';
BEGIN
  -- delete citydb.ur_trafficfacilitys
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_trafficfacility t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      parkingplaceattribute_id,
      urbanrapidtransitrailroad_id,
      urbanroadattribute_id,
      vehicleterminalattribute_id
  )
  SELECT
    array_agg(id),
    array_agg(parkingplaceattribute_id),
    array_agg(urbanrapidtransitrailroad_id),
    array_agg(urbanroadattribute_id),
    array_agg(vehicleterminalattribute_id)
  INTO
    deleted_ids,
    ur_parkingplaceattribute_ids,
    ur_urbanrapidtransitrailr_ids,
    ur_urbanroadattribute_ids,
    ur_vehicleterminalattribu_ids
  FROM
    delete_objects;

  -- delete citydb.ur_parkingplaceattribute(s)
  IF -1 = ALL(ur_parkingplaceattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_parkingplaceattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_parkingplaceattribute_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_urbanrapidtransitrailr(s)
  IF -1 = ALL(ur_urbanrapidtransitrailr_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_urbanrapidtransitrailr(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_urbanrapidtransitrailr_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_urbanroadattribute(s)
  IF -1 = ALL(ur_urbanroadattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_urbanroadattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_urbanroadattribute_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_vehicleterminalattribu(s)
  IF -1 = ALL(ur_vehicleterminalattribu_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_vehicleterminalattribu(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_vehicleterminalattribu_ids) AS a_id) a;
  END IF;

  IF $2 <> 1 THEN
    -- delete ur_urbanfacility
    PERFORM citydb.del_ur_urbanfacility(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_trafficfacility(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_trafficfacility(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_trafficobjectusecaseat(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_trafficobjectusecaseats
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_trafficobjectusecaseat t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_trafficobjectusecaseat(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_trafficobjectusecaseat(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_trafficvolumeattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_trafficvolumeattributes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_trafficvolumeattribute t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_roadattribute
    PERFORM citydb.del_ur_roadattribute(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_trafficvolumeattribute(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_trafficvolumeattribute(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_transfer(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_transfers
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_transfer t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_publictransitdatatype
    PERFORM citydb.del_ur_publictransitdatatype(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_transfer(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_transfer(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_transitioncurvetype(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_transitioncurvetypes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_transitioncurvetype t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_transitioncurvetype(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_transitioncurvetype(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_translation(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_translations
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_translation t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_publictransitdatatype
    PERFORM citydb.del_ur_publictransitdatatype(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_translation(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_translation(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_translationjp(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_translationjps
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_translationjp t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_publictransit
    PERFORM citydb.del_ur_publictransit(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_translationjp(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_translationjp(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_transportation_complex(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_dmattribute_ids bigint[] := '{}';
  ur_facilityattribute_ids bigint[] := '{}';
  ur_keyvaluepairattribute_ids bigint[] := '{}';
  ur_dataqualityattribute_ids bigint[] := '{}';
  ur_facilityidattribute_ids bigint[] := '{}';
  ur_facilitytypeattribute_ids bigint[] := '{}';
  ur_railwayrouteattribute_ids bigint[] := '{}';
  ur_roadstructureattribute_ids bigint[] := '{}';
  ur_roadtype_ids bigint[] := '{}';
  ur_squareurbanplanattribu_ids bigint[] := '{}';
  ur_trackattribute_ids bigint[] := '{}';
  ur_trafficobjectusecaseat_ids bigint[] := '{}';
  ur_trafficvolumeattribute_ids bigint[] := '{}';
BEGIN
  -- delete references to ur_dmattributes
  WITH del_ur_dmattribute_refs AS (
    DELETE FROM
      citydb.ur_transport_to_dmattribu t
    USING
      unnest($1) a(a_id)
    WHERE
      t.transportation_complex_id = a.a_id
    RETURNING
      t.dmattribute_id
  )
  SELECT
    array_agg(dmattribute_id)
  INTO
    ur_dmattribute_ids
  FROM
    del_ur_dmattribute_refs;

  -- delete citydb.ur_dmattribute(s)
  IF -1 = ALL(ur_dmattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_dmattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_dmattribute_ids) AS a_id) a;
  END IF;

  -- delete references to ur_facilityattributes
  WITH del_ur_facilityattribute_refs AS (
    DELETE FROM
      citydb.ur_transport_to_facilitya t
    USING
      unnest($1) a(a_id)
    WHERE
      t.transportation_complex_id = a.a_id
    RETURNING
      t.facilityattribute_id
  )
  SELECT
    array_agg(facilityattribute_id)
  INTO
    ur_facilityattribute_ids
  FROM
    del_ur_facilityattribute_refs;

  -- delete citydb.ur_facilityattribute(s)
  IF -1 = ALL(ur_facilityattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_facilityattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_facilityattribute_ids) AS a_id) a;
  END IF;

  -- delete references to ur_keyvaluepairattributes
  WITH del_ur_keyvaluepairattribute_refs AS (
    DELETE FROM
      citydb.ur_transport_to_keyvaluep t
    USING
      unnest($1) a(a_id)
    WHERE
      t.transportation_complex_id = a.a_id
    RETURNING
      t.keyvaluepairattribute_id
  )
  SELECT
    array_agg(keyvaluepairattribute_id)
  INTO
    ur_keyvaluepairattribute_ids
  FROM
    del_ur_keyvaluepairattribute_refs;

  -- delete citydb.ur_keyvaluepairattribute(s)
  IF -1 = ALL(ur_keyvaluepairattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_keyvaluepairattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_keyvaluepairattribute_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_transportation_complexs
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_transportation_complex t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      trandataqualityattribute_id,
      tranfacilityidattribute_id,
      tranfacilitytypeattribute_id,
      railwayrouteattribute_id,
      roadstructureattribute_id,
      roadstatus_id,
      squareurbanplanattribute_id,
      trackattribute_id,
      tranusecaseattribute_id,
      trafficvolumeattribute_id
  )
  SELECT
    array_agg(id),
    array_agg(trandataqualityattribute_id),
    array_agg(tranfacilityidattribute_id),
    array_agg(tranfacilitytypeattribute_id),
    array_agg(railwayrouteattribute_id),
    array_agg(roadstructureattribute_id),
    array_agg(roadstatus_id),
    array_agg(squareurbanplanattribute_id),
    array_agg(trackattribute_id),
    array_agg(tranusecaseattribute_id),
    array_agg(trafficvolumeattribute_id)
  INTO
    deleted_ids,
    ur_dataqualityattribute_ids,
    ur_facilityidattribute_ids,
    ur_facilitytypeattribute_ids,
    ur_railwayrouteattribute_ids,
    ur_roadstructureattribute_ids,
    ur_roadtype_ids,
    ur_squareurbanplanattribu_ids,
    ur_trackattribute_ids,
    ur_trafficobjectusecaseat_ids,
    ur_trafficvolumeattribute_ids
  FROM
    delete_objects;

  -- delete citydb.ur_dataqualityattribute(s)
  IF -1 = ALL(ur_dataqualityattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_dataqualityattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_dataqualityattribute_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_facilityidattribute(s)
  IF -1 = ALL(ur_facilityidattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_facilityidattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_facilityidattribute_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_facilitytypeattribute(s)
  IF -1 = ALL(ur_facilitytypeattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_facilitytypeattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_facilitytypeattribute_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_railwayrouteattribute(s)
  IF -1 = ALL(ur_railwayrouteattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_railwayrouteattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_railwayrouteattribute_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_roadstructureattribute(s)
  IF -1 = ALL(ur_roadstructureattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_roadstructureattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_roadstructureattribute_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_roadtype(s)
  IF -1 = ALL(ur_roadtype_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_roadtype(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_roadtype_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_squareurbanplanattribu(s)
  IF -1 = ALL(ur_squareurbanplanattribu_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_squareurbanplanattribu(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_squareurbanplanattribu_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_trackattribute(s)
  IF -1 = ALL(ur_trackattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_trackattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_trackattribute_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_trafficobjectusecaseat(s)
  IF -1 = ALL(ur_trafficobjectusecaseat_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_trafficobjectusecaseat(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_trafficobjectusecaseat_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_trafficvolumeattribute(s)
  IF -1 = ALL(ur_trafficvolumeattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_trafficvolumeattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_trafficvolumeattribute_ids) AS a_id) a;
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_transportation_complex(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_transportation_complex(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_treatmentfacility(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_sewersystemattribute_ids bigint[] := '{}';
BEGIN
  -- delete citydb.ur_treatmentfacilitys
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_treatmentfacility t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      sewersystemsattribute_id
  )
  SELECT
    array_agg(id),
    array_agg(sewersystemsattribute_id)
  INTO
    deleted_ids,
    ur_sewersystemattribute_ids
  FROM
    delete_objects;

  -- delete citydb.ur_sewersystemattribute(s)
  IF -1 = ALL(ur_sewersystemattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_sewersystemattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_sewersystemattribute_ids) AS a_id) a;
  END IF;

  IF $2 <> 1 THEN
    -- delete ur_urbanfacility
    PERFORM citydb.del_ur_urbanfacility(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_treatmentfacility(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_treatmentfacility(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_treeplantingdistrict(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_treeplantingdistricts
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_treeplantingdistrict t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_districtsandzones
    PERFORM citydb.del_ur_districtsandzones(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_treeplantingdistrict(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_treeplantingdistrict(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_trip(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_trips
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_trip t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_publictransit
    PERFORM citydb.del_ur_publictransit(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_trip(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_trip(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_tunnel(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_disasterriskattribute_ids bigint[] := '{}';
  ur_dmattribute_ids bigint[] := '{}';
  ur_facilityattribute_ids bigint[] := '{}';
  ur_keyvaluepairattribute_ids bigint[] := '{}';
  ur_constructionbaseattrib_ids bigint[] := '{}';
  ur_constructionriskassess_ids bigint[] := '{}';
  ur_dataqualityattribute_ids bigint[] := '{}';
  ur_facilityidattribute_ids bigint[] := '{}';
  ur_facilitytypeattribute_ids bigint[] := '{}';
  ur_tunnelfunctionalattrib_ids bigint[] := '{}';
  ur_tunnelstructureattribu_ids bigint[] := '{}';
BEGIN
  -- delete references to ur_disasterriskattributes
  WITH del_ur_disasterriskattribute_refs AS (
    DELETE FROM
      citydb.ur_tunnel_to_disasterr t
    USING
      unnest($1) a(a_id)
    WHERE
      t.tunnel_id = a.a_id
    RETURNING
      t.disasterriskattribute_id
  )
  SELECT
    array_agg(disasterriskattribute_id)
  INTO
    ur_disasterriskattribute_ids
  FROM
    del_ur_disasterriskattribute_refs;

  -- delete citydb.ur_disasterriskattribute(s)
  IF -1 = ALL(ur_disasterriskattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_disasterriskattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_disasterriskattribute_ids) AS a_id) a;
  END IF;

  -- delete references to ur_dmattributes
  WITH del_ur_dmattribute_refs AS (
    DELETE FROM
      citydb.ur_tunnel_to_dmattribu t
    USING
      unnest($1) a(a_id)
    WHERE
      t.tunnel_id = a.a_id
    RETURNING
      t.dmattribute_id
  )
  SELECT
    array_agg(dmattribute_id)
  INTO
    ur_dmattribute_ids
  FROM
    del_ur_dmattribute_refs;

  -- delete citydb.ur_dmattribute(s)
  IF -1 = ALL(ur_dmattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_dmattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_dmattribute_ids) AS a_id) a;
  END IF;

  -- delete references to ur_facilityattributes
  WITH del_ur_facilityattribute_refs AS (
    DELETE FROM
      citydb.ur_tunnel_to_facilitya t
    USING
      unnest($1) a(a_id)
    WHERE
      t.tunnel_id = a.a_id
    RETURNING
      t.facilityattribute_id
  )
  SELECT
    array_agg(facilityattribute_id)
  INTO
    ur_facilityattribute_ids
  FROM
    del_ur_facilityattribute_refs;

  -- delete citydb.ur_facilityattribute(s)
  IF -1 = ALL(ur_facilityattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_facilityattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_facilityattribute_ids) AS a_id) a;
  END IF;

  -- delete references to ur_keyvaluepairattributes
  WITH del_ur_keyvaluepairattribute_refs AS (
    DELETE FROM
      citydb.ur_tunnel_to_keyvaluep t
    USING
      unnest($1) a(a_id)
    WHERE
      t.tunnel_id = a.a_id
    RETURNING
      t.keyvaluepairattribute_id
  )
  SELECT
    array_agg(keyvaluepairattribute_id)
  INTO
    ur_keyvaluepairattribute_ids
  FROM
    del_ur_keyvaluepairattribute_refs;

  -- delete citydb.ur_keyvaluepairattribute(s)
  IF -1 = ALL(ur_keyvaluepairattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_keyvaluepairattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_keyvaluepairattribute_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_tunnels
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_tunnel t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      tunbaseattribute_id,
      tunriskassessmentattribut_id,
      tundataqualityattribute_id,
      tunfacilityidattribute_id,
      tunfacilitytypeattribute_id,
      tunfunctionalattribute_id,
      tunstructureattribute_id
  )
  SELECT
    array_agg(id),
    array_agg(tunbaseattribute_id),
    array_agg(tunriskassessmentattribut_id),
    array_agg(tundataqualityattribute_id),
    array_agg(tunfacilityidattribute_id),
    array_agg(tunfacilitytypeattribute_id),
    array_agg(tunfunctionalattribute_id),
    array_agg(tunstructureattribute_id)
  INTO
    deleted_ids,
    ur_constructionbaseattrib_ids,
    ur_constructionriskassess_ids,
    ur_dataqualityattribute_ids,
    ur_facilityidattribute_ids,
    ur_facilitytypeattribute_ids,
    ur_tunnelfunctionalattrib_ids,
    ur_tunnelstructureattribu_ids
  FROM
    delete_objects;

  -- delete citydb.ur_constructionbaseattrib(s)
  IF -1 = ALL(ur_constructionbaseattrib_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_constructionbaseattrib(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_constructionbaseattrib_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_constructionriskassess(s)
  IF -1 = ALL(ur_constructionriskassess_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_constructionriskassess(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_constructionriskassess_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_dataqualityattribute(s)
  IF -1 = ALL(ur_dataqualityattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_dataqualityattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_dataqualityattribute_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_facilityidattribute(s)
  IF -1 = ALL(ur_facilityidattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_facilityidattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_facilityidattribute_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_facilitytypeattribute(s)
  IF -1 = ALL(ur_facilitytypeattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_facilitytypeattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_facilitytypeattribute_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_tunnelfunctionalattrib(s)
  IF -1 = ALL(ur_tunnelfunctionalattrib_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_tunnelfunctionalattrib(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_tunnelfunctionalattrib_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_tunnelstructureattribu(s)
  IF -1 = ALL(ur_tunnelstructureattribu_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_tunnelstructureattribu(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_tunnelstructureattribu_ids) AS a_id) a;
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_tunnel(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_tunnel(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_tunnelfunctionalattrib(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_tunnelfunctionalattribs
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_tunnelfunctionalattrib t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_tunnelfunctionalattrib(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_tunnelfunctionalattrib(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_tunnelstructureattribu(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_tunnelstructureattribus
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_tunnelstructureattribu t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_tunnelstructureattribu(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_tunnelstructureattribu(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_undergroundbuilding(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_undergroundbuildings
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_undergroundbuilding t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete building
    PERFORM citydb.del_building(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_undergroundbuilding(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_undergroundbuilding(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_urbandevelopmentproj_2(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  IF $2 <> 2 THEN
    FOR rec IN
      SELECT
        co.id, co.objectclass_id
      FROM
        citydb.cityobject co, unnest($1) a(a_id)
      WHERE
        co.id = a.a_id
    LOOP
      object_id := rec.id::bigint;
      objectclass_id := rec.objectclass_id::integer;
      CASE
        -- delete ur_landreadjustmentprojec
        WHEN objectclass_id = 60340 THEN
          dummy_id := citydb.del_ur_landreadjustmentprojec(array_agg(object_id), 1);
        -- delete ur_newhousingandurbandeve
        WHEN objectclass_id = 60341 THEN
          dummy_id := citydb.del_ur_newhousingandurbandeve(array_agg(object_id), 1);
        -- delete ur_industrialparkdevelopm
        WHEN objectclass_id = 60342 THEN
          dummy_id := citydb.del_ur_industrialparkdevelopm(array_agg(object_id), 1);
        -- delete ur_urbanredevelopmentproj
        WHEN objectclass_id = 60343 THEN
          dummy_id := citydb.del_ur_urbanredevelopmentproj(array_agg(object_id), 1);
        -- delete ur_newurbaninfrastructure
        WHEN objectclass_id = 60344 THEN
          dummy_id := citydb.del_ur_newurbaninfrastructure(array_agg(object_id), 1);
        -- delete ur_residentialblockconstr
        WHEN objectclass_id = 60345 THEN
          dummy_id := citydb.del_ur_residentialblockconstr(array_agg(object_id), 1);
        -- delete ur_disasterpreventionbloc
        WHEN objectclass_id = 60346 THEN
          dummy_id := citydb.del_ur_disasterpreventionbloc(array_agg(object_id), 1);
        -- delete ur_urbanrenewalproject
        WHEN objectclass_id = 60347 THEN
          dummy_id := citydb.del_ur_urbanrenewalproject(array_agg(object_id), 1);
        ELSE
          dummy_id := NULL;
      END CASE;

      IF dummy_id = object_id THEN
        deleted_child_ids := array_append(deleted_child_ids, dummy_id);
      END IF;
    END LOOP;
  END IF;

  -- delete citydb.ur_urbandevelopmentproj_2s
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_urbandevelopmentproj_2 t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_zone
    PERFORM citydb.del_ur_zone(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_urbandevelopmentproj_2(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_urbandevelopmentproj_2(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_urbandevelopmentprojec(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_urbandevelopmentprojecs
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_urbandevelopmentprojec t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_urbandevelopmentprojec(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_urbandevelopmentprojec(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_urbandisasterrecoveryp(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_urbandisasterrecoveryps
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_urbandisasterrecoveryp t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_zone
    PERFORM citydb.del_ur_zone(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_urbandisasterrecoveryp(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_urbandisasterrecoveryp(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_urbanfacility(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  IF $2 <> 2 THEN
    FOR rec IN
      SELECT
        co.id, co.objectclass_id
      FROM
        citydb.cityobject co, unnest($1) a(a_id)
      WHERE
        co.id = a.a_id
    LOOP
      object_id := rec.id::bigint;
      objectclass_id := rec.objectclass_id::integer;
      CASE
        -- delete ur_trafficfacility
        WHEN objectclass_id = 60354 THEN
          dummy_id := citydb.del_ur_trafficfacility(array_agg(object_id), 1);
        -- delete ur_openspaceforpublicuse
        WHEN objectclass_id = 60355 THEN
          dummy_id := citydb.del_ur_openspaceforpublicuse(array_agg(object_id), 1);
        -- delete ur_supplyfacility
        WHEN objectclass_id = 60356 THEN
          dummy_id := citydb.del_ur_supplyfacility(array_agg(object_id), 1);
        -- delete ur_treatmentfacility
        WHEN objectclass_id = 60357 THEN
          dummy_id := citydb.del_ur_treatmentfacility(array_agg(object_id), 1);
        -- delete ur_waterway_2
        WHEN objectclass_id = 60358 THEN
          dummy_id := citydb.del_ur_waterway_2(array_agg(object_id), 1);
        -- delete ur_collectivehousingfacil
        WHEN objectclass_id = 60363 THEN
          dummy_id := citydb.del_ur_collectivehousingfacil(array_agg(object_id), 1);
        -- delete ur_collectivegovernmentan
        WHEN objectclass_id = 60364 THEN
          dummy_id := citydb.del_ur_collectivegovernmentan(array_agg(object_id), 1);
        -- delete ur_collectiveurbandisaste
        WHEN objectclass_id = 60365 THEN
          dummy_id := citydb.del_ur_collectiveurbandisaste(array_agg(object_id), 1);
        -- delete ur_distributionbusinesspa
        WHEN objectclass_id = 60366 THEN
          dummy_id := citydb.del_ur_distributionbusinesspa(array_agg(object_id), 1);
        -- delete ur_urbanfacilitystipulate
        WHEN objectclass_id = 60367 THEN
          dummy_id := citydb.del_ur_urbanfacilitystipulate(array_agg(object_id), 1);
        -- delete ur_collectivefacilitiesfo
        WHEN objectclass_id = 60368 THEN
          dummy_id := citydb.del_ur_collectivefacilitiesfo(array_agg(object_id), 1);
        -- delete ur_collectivefacilities_2
        WHEN objectclass_id = 60369 THEN
          dummy_id := citydb.del_ur_collectivefacilities_2(array_agg(object_id), 1);
        -- delete ur_collectivefacilities_3
        WHEN objectclass_id = 60370 THEN
          dummy_id := citydb.del_ur_collectivefacilities_3(array_agg(object_id), 1);
        -- delete ur_urbanfacilitystipulate
        WHEN objectclass_id = 60384 THEN
          dummy_id := citydb.del_ur_urbanfacilitystipulate(array_agg(object_id), 1);
        -- delete ur_urbanfacilitystipulate
        WHEN objectclass_id = 60385 THEN
          dummy_id := citydb.del_ur_urbanfacilitystipulate(array_agg(object_id), 1);
        -- delete ur_urbanfacilitystipulate
        WHEN objectclass_id = 60386 THEN
          dummy_id := citydb.del_ur_urbanfacilitystipulate(array_agg(object_id), 1);
        -- delete ur_urbanfacilitystipulate
        WHEN objectclass_id = 60387 THEN
          dummy_id := citydb.del_ur_urbanfacilitystipulate(array_agg(object_id), 1);
        -- delete ur_urbanfacilitystipulate
        WHEN objectclass_id = 60388 THEN
          dummy_id := citydb.del_ur_urbanfacilitystipulate(array_agg(object_id), 1);
        -- delete ur_urbanfacilitystipulate
        WHEN objectclass_id = 60389 THEN
          dummy_id := citydb.del_ur_urbanfacilitystipulate(array_agg(object_id), 1);
        -- delete ur_urbanfacilitystipulate
        WHEN objectclass_id = 60390 THEN
          dummy_id := citydb.del_ur_urbanfacilitystipulate(array_agg(object_id), 1);
        ELSE
          dummy_id := NULL;
      END CASE;

      IF dummy_id = object_id THEN
        deleted_child_ids := array_append(deleted_child_ids, dummy_id);
      END IF;
    END LOOP;
  END IF;

  -- delete citydb.ur_urbanfacilitys
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_urbanfacility t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_zone
    PERFORM citydb.del_ur_zone(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_urbanfacility(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_urbanfacility(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_urbanfacilitystatus(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_urbanfacilitystatuss
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_urbanfacilitystatus t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_urbanfunction
    PERFORM citydb.del_ur_urbanfunction(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_urbanfacilitystatus(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_urbanfacilitystatus(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_urbanfacilitystipulate(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_urbanfacilitystipulates
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_urbanfacilitystipulate t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_urbanfacility
    PERFORM citydb.del_ur_urbanfacility(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_urbanfacilitystipulate(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_urbanfacilitystipulate(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_urbanfunction(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_keyvaluepairattribute_ids bigint[] := '{}';
  surface_geometry_ids bigint[] := '{}';
  ur_dataqualityattribute_ids bigint[] := '{}';
BEGIN
  -- delete references to ur_keyvaluepairattributes
  WITH del_ur_keyvaluepairattribute_refs AS (
    DELETE FROM
      citydb.ur_urbanfunc_to_keyvaluep t
    USING
      unnest($1) a(a_id)
    WHERE
      t.urbanfunction_id = a.a_id
    RETURNING
      t.keyvaluepairattribute_id
  )
  SELECT
    array_agg(keyvaluepairattribute_id)
  INTO
    ur_keyvaluepairattribute_ids
  FROM
    del_ur_keyvaluepairattribute_refs;

  -- delete citydb.ur_keyvaluepairattribute(s)
  IF -1 = ALL(ur_keyvaluepairattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_keyvaluepairattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_keyvaluepairattribute_ids) AS a_id) a;
  END IF;

  IF $2 <> 2 THEN
    FOR rec IN
      SELECT
        co.id, co.objectclass_id
      FROM
        citydb.cityobject co, unnest($1) a(a_id)
      WHERE
        co.id = a.a_id
    LOOP
      object_id := rec.id::bigint;
      objectclass_id := rec.objectclass_id::integer;
      CASE
        -- delete ur_zone
        WHEN objectclass_id = 60259 THEN
          dummy_id := citydb.del_ur_zone(array_agg(object_id), 1);
        -- delete ur_threedimensionalextent
        WHEN objectclass_id = 60260 THEN
          dummy_id := citydb.del_ur_threedimensionalextent(array_agg(object_id), 1);
        -- delete ur_administration
        WHEN objectclass_id = 60261 THEN
          dummy_id := citydb.del_ur_administration(array_agg(object_id), 1);
        -- delete ur_disasterdamage
        WHEN objectclass_id = 60262 THEN
          dummy_id := citydb.del_ur_disasterdamage(array_agg(object_id), 1);
        -- delete ur_pollution
        WHEN objectclass_id = 60263 THEN
          dummy_id := citydb.del_ur_pollution(array_agg(object_id), 1);
        -- delete ur_disasterpreventionbase
        WHEN objectclass_id = 60264 THEN
          dummy_id := citydb.del_ur_disasterpreventionbase(array_agg(object_id), 1);
        -- delete ur_recreations
        WHEN objectclass_id = 60265 THEN
          dummy_id := citydb.del_ur_recreations(array_agg(object_id), 1);
        -- delete ur_landusediversion_2
        WHEN objectclass_id = 60267 THEN
          dummy_id := citydb.del_ur_landusediversion_2(array_agg(object_id), 1);
        -- delete ur_urbanization
        WHEN objectclass_id = 60268 THEN
          dummy_id := citydb.del_ur_urbanization(array_agg(object_id), 1);
        -- delete ur_did
        WHEN objectclass_id = 60271 THEN
          dummy_id := citydb.del_ur_did(array_agg(object_id), 1);
        -- delete ur_censusblock
        WHEN objectclass_id = 60272 THEN
          dummy_id := citydb.del_ur_censusblock(array_agg(object_id), 1);
        -- delete ur_developmentproject
        WHEN objectclass_id = 60273 THEN
          dummy_id := citydb.del_ur_developmentproject(array_agg(object_id), 1);
        -- delete ur_newhousing
        WHEN objectclass_id = 60274 THEN
          dummy_id := citydb.del_ur_newhousing(array_agg(object_id), 1);
        -- delete ur_urbanfacilitystatus
        WHEN objectclass_id = 60275 THEN
          dummy_id := citydb.del_ur_urbanfacilitystatus(array_agg(object_id), 1);
        -- delete ur_publictransitfacility
        WHEN objectclass_id = 60276 THEN
          dummy_id := citydb.del_ur_publictransitfacility(array_agg(object_id), 1);
        -- delete ur_landprice_2
        WHEN objectclass_id = 60277 THEN
          dummy_id := citydb.del_ur_landprice_2(array_agg(object_id), 1);
        -- delete ur_weatherobservation
        WHEN objectclass_id = 60279 THEN
          dummy_id := citydb.del_ur_weatherobservation(array_agg(object_id), 1);
        -- delete ur_scenicresource
        WHEN objectclass_id = 60282 THEN
          dummy_id := citydb.del_ur_scenicresource(array_agg(object_id), 1);
        -- delete ur_urbanplanningarea
        WHEN objectclass_id = 60283 THEN
          dummy_id := citydb.del_ur_urbanplanningarea(array_agg(object_id), 0);
        -- delete ur_quasiurbanplanningarea
        WHEN objectclass_id = 60284 THEN
          dummy_id := citydb.del_ur_quasiurbanplanningarea(array_agg(object_id), 0);
        -- delete ur_areaclassification
        WHEN objectclass_id = 60285 THEN
          dummy_id := citydb.del_ur_areaclassification(array_agg(object_id), 0);
        -- delete ur_districtsandzones
        WHEN objectclass_id = 60286 THEN
          dummy_id := citydb.del_ur_districtsandzones(array_agg(object_id), 0);
        -- delete ur_projectpromotionarea
        WHEN objectclass_id = 60287 THEN
          dummy_id := citydb.del_ur_projectpromotionarea(array_agg(object_id), 0);
        -- delete ur_zone
        WHEN objectclass_id = 60288 THEN
          dummy_id := citydb.del_ur_zone(array_agg(object_id), 1);
        -- delete ur_urbandisasterrecoveryp
        WHEN objectclass_id = 60289 THEN
          dummy_id := citydb.del_ur_urbandisasterrecoveryp(array_agg(object_id), 0);
        -- delete ur_urbandevelopmentproj_2
        WHEN objectclass_id = 60290 THEN
          dummy_id := citydb.del_ur_urbandevelopmentproj_2(array_agg(object_id), 0);
        -- delete ur_scheduledareaforurband
        WHEN objectclass_id = 60291 THEN
          dummy_id := citydb.del_ur_scheduledareaforurband(array_agg(object_id), 0);
        -- delete ur_urbanfacility
        WHEN objectclass_id = 60292 THEN
          dummy_id := citydb.del_ur_urbanfacility(array_agg(object_id), 0);
        -- delete ur_abstractdistrictplan
        WHEN objectclass_id = 60293 THEN
          dummy_id := citydb.del_ur_abstractdistrictplan(array_agg(object_id), 0);
        -- delete ur_districtdevelopmentpla
        WHEN objectclass_id = 60294 THEN
          dummy_id := citydb.del_ur_districtdevelopmentpla(array_agg(object_id), 0);
        -- delete ur_district
        WHEN objectclass_id = 60295 THEN
          dummy_id := citydb.del_ur_district(array_agg(object_id), 0);
        -- delete ur_zone
        WHEN objectclass_id = 60296 THEN
          dummy_id := citydb.del_ur_zone(array_agg(object_id), 1);
        -- delete ur_zonaldisasterpreventio
        WHEN objectclass_id = 60297 THEN
          dummy_id := citydb.del_ur_zonaldisasterpreventio(array_agg(object_id), 0);
        -- delete ur_zone
        WHEN objectclass_id = 60298 THEN
          dummy_id := citydb.del_ur_zone(array_agg(object_id), 1);
        -- delete ur_urgenturbanrenewalarea
        WHEN objectclass_id = 60299 THEN
          dummy_id := citydb.del_ur_urgenturbanrenewalarea(array_agg(object_id), 0);
        -- delete ur_privateurbanrenewalpro
        WHEN objectclass_id = 60300 THEN
          dummy_id := citydb.del_ur_privateurbanrenewalpro(array_agg(object_id), 0);
        -- delete ur_globalhubcitydevelopme
        WHEN objectclass_id = 60301 THEN
          dummy_id := citydb.del_ur_globalhubcitydevelopme(array_agg(object_id), 0);
        -- delete ur_agreement
        WHEN objectclass_id = 60302 THEN
          dummy_id := citydb.del_ur_agreement(array_agg(object_id), 0);
        -- delete ur_zone
        WHEN objectclass_id = 60303 THEN
          dummy_id := citydb.del_ur_zone(array_agg(object_id), 1);
        -- delete ur_sedimentdisasterpronea
        WHEN objectclass_id = 60304 THEN
          dummy_id := citydb.del_ur_sedimentdisasterpronea(array_agg(object_id), 0);
        -- delete ur_zone
        WHEN objectclass_id = 60305 THEN
          dummy_id := citydb.del_ur_zone(array_agg(object_id), 1);
        -- delete ur_zone
        WHEN objectclass_id = 60306 THEN
          dummy_id := citydb.del_ur_zone(array_agg(object_id), 1);
        -- delete ur_zone
        WHEN objectclass_id = 60307 THEN
          dummy_id := citydb.del_ur_zone(array_agg(object_id), 1);
        -- delete ur_zone
        WHEN objectclass_id = 60308 THEN
          dummy_id := citydb.del_ur_zone(array_agg(object_id), 1);
        -- delete ur_usedistrict
        WHEN objectclass_id = 60309 THEN
          dummy_id := citydb.del_ur_usedistrict(array_agg(object_id), 0);
        -- delete ur_specialusedistrict
        WHEN objectclass_id = 60310 THEN
          dummy_id := citydb.del_ur_specialusedistrict(array_agg(object_id), 0);
        -- delete ur_specialuserestrictiond
        WHEN objectclass_id = 60311 THEN
          dummy_id := citydb.del_ur_specialuserestrictiond(array_agg(object_id), 0);
        -- delete ur_exceptionalfloorareara
        WHEN objectclass_id = 60312 THEN
          dummy_id := citydb.del_ur_exceptionalfloorareara(array_agg(object_id), 0);
        -- delete ur_highriseresidentialatt
        WHEN objectclass_id = 60313 THEN
          dummy_id := citydb.del_ur_highriseresidentialatt(array_agg(object_id), 0);
        -- delete ur_heightcontroldistrict
        WHEN objectclass_id = 60314 THEN
          dummy_id := citydb.del_ur_heightcontroldistrict(array_agg(object_id), 0);
        -- delete ur_highlevelusedistrict
        WHEN objectclass_id = 60315 THEN
          dummy_id := citydb.del_ur_highlevelusedistrict(array_agg(object_id), 0);
        -- delete ur_specifiedblock
        WHEN objectclass_id = 60316 THEN
          dummy_id := citydb.del_ur_specifiedblock(array_agg(object_id), 0);
        -- delete ur_specialurbanrenaissanc
        WHEN objectclass_id = 60317 THEN
          dummy_id := citydb.del_ur_specialurbanrenaissanc(array_agg(object_id), 0);
        -- delete ur_districtsandzones
        WHEN objectclass_id = 60318 THEN
          dummy_id := citydb.del_ur_districtsandzones(array_agg(object_id), 0);
        -- delete ur_residentialenvironment
        WHEN objectclass_id = 60319 THEN
          dummy_id := citydb.del_ur_residentialenvironment(array_agg(object_id), 0);
        -- delete ur_specialuseattractiondi
        WHEN objectclass_id = 60320 THEN
          dummy_id := citydb.del_ur_specialuseattractiondi(array_agg(object_id), 0);
        -- delete ur_districtsandzones
        WHEN objectclass_id = 60321 THEN
          dummy_id := citydb.del_ur_districtsandzones(array_agg(object_id), 0);
        -- delete ur_specifieddisasterpreve
        WHEN objectclass_id = 60322 THEN
          dummy_id := citydb.del_ur_specifieddisasterpreve(array_agg(object_id), 0);
        -- delete ur_landscapezone
        WHEN objectclass_id = 60323 THEN
          dummy_id := citydb.del_ur_landscapezone(array_agg(object_id), 0);
        -- delete ur_scenicdistrict
        WHEN objectclass_id = 60324 THEN
          dummy_id := citydb.del_ur_scenicdistrict(array_agg(object_id), 0);
        -- delete ur_districtsandzones
        WHEN objectclass_id = 60325 THEN
          dummy_id := citydb.del_ur_districtsandzones(array_agg(object_id), 0);
        -- delete ur_portzone
        WHEN objectclass_id = 60326 THEN
          dummy_id := citydb.del_ur_portzone(array_agg(object_id), 0);
        -- delete ur_districtsandzones
        WHEN objectclass_id = 60327 THEN
          dummy_id := citydb.del_ur_districtsandzones(array_agg(object_id), 0);
        -- delete ur_districtsandzones
        WHEN objectclass_id = 60328 THEN
          dummy_id := citydb.del_ur_districtsandzones(array_agg(object_id), 0);
        -- delete ur_districtsandzones
        WHEN objectclass_id = 60329 THEN
          dummy_id := citydb.del_ur_districtsandzones(array_agg(object_id), 0);
        -- delete ur_specialgreenspaceconse
        WHEN objectclass_id = 60330 THEN
          dummy_id := citydb.del_ur_specialgreenspaceconse(array_agg(object_id), 0);
        -- delete ur_treeplantingdistrict
        WHEN objectclass_id = 60331 THEN
          dummy_id := citydb.del_ur_treeplantingdistrict(array_agg(object_id), 0);
        -- delete ur_distributionbusinesszo
        WHEN objectclass_id = 60332 THEN
          dummy_id := citydb.del_ur_distributionbusinesszo(array_agg(object_id), 0);
        -- delete ur_productivegreenzone
        WHEN objectclass_id = 60333 THEN
          dummy_id := citydb.del_ur_productivegreenzone(array_agg(object_id), 0);
        -- delete ur_districtsandzones
        WHEN objectclass_id = 60334 THEN
          dummy_id := citydb.del_ur_districtsandzones(array_agg(object_id), 0);
        -- delete ur_districtsandzones
        WHEN objectclass_id = 60335 THEN
          dummy_id := citydb.del_ur_districtsandzones(array_agg(object_id), 0);
        -- delete ur_urbanredevelopmentprom
        WHEN objectclass_id = 60336 THEN
          dummy_id := citydb.del_ur_urbanredevelopmentprom(array_agg(object_id), 0);
        -- delete ur_projectpromotionarea
        WHEN objectclass_id = 60337 THEN
          dummy_id := citydb.del_ur_projectpromotionarea(array_agg(object_id), 0);
        -- delete ur_projectpromotionarea
        WHEN objectclass_id = 60338 THEN
          dummy_id := citydb.del_ur_projectpromotionarea(array_agg(object_id), 0);
        -- delete ur_projectpromotionarea
        WHEN objectclass_id = 60339 THEN
          dummy_id := citydb.del_ur_projectpromotionarea(array_agg(object_id), 0);
        -- delete ur_landreadjustmentprojec
        WHEN objectclass_id = 60340 THEN
          dummy_id := citydb.del_ur_landreadjustmentprojec(array_agg(object_id), 0);
        -- delete ur_newhousingandurbandeve
        WHEN objectclass_id = 60341 THEN
          dummy_id := citydb.del_ur_newhousingandurbandeve(array_agg(object_id), 0);
        -- delete ur_industrialparkdevelopm
        WHEN objectclass_id = 60342 THEN
          dummy_id := citydb.del_ur_industrialparkdevelopm(array_agg(object_id), 0);
        -- delete ur_urbanredevelopmentproj
        WHEN objectclass_id = 60343 THEN
          dummy_id := citydb.del_ur_urbanredevelopmentproj(array_agg(object_id), 0);
        -- delete ur_newurbaninfrastructure
        WHEN objectclass_id = 60344 THEN
          dummy_id := citydb.del_ur_newurbaninfrastructure(array_agg(object_id), 0);
        -- delete ur_residentialblockconstr
        WHEN objectclass_id = 60345 THEN
          dummy_id := citydb.del_ur_residentialblockconstr(array_agg(object_id), 0);
        -- delete ur_disasterpreventionbloc
        WHEN objectclass_id = 60346 THEN
          dummy_id := citydb.del_ur_disasterpreventionbloc(array_agg(object_id), 0);
        -- delete ur_urbanrenewalproject
        WHEN objectclass_id = 60347 THEN
          dummy_id := citydb.del_ur_urbanrenewalproject(array_agg(object_id), 0);
        -- delete ur_scheduledareaforurband
        WHEN objectclass_id = 60348 THEN
          dummy_id := citydb.del_ur_scheduledareaforurband(array_agg(object_id), 0);
        -- delete ur_scheduledareaforurband
        WHEN objectclass_id = 60349 THEN
          dummy_id := citydb.del_ur_scheduledareaforurband(array_agg(object_id), 0);
        -- delete ur_scheduledareaforurband
        WHEN objectclass_id = 60350 THEN
          dummy_id := citydb.del_ur_scheduledareaforurband(array_agg(object_id), 0);
        -- delete ur_scheduledareaforurband
        WHEN objectclass_id = 60351 THEN
          dummy_id := citydb.del_ur_scheduledareaforurband(array_agg(object_id), 0);
        -- delete ur_scheduledareaforurband
        WHEN objectclass_id = 60352 THEN
          dummy_id := citydb.del_ur_scheduledareaforurband(array_agg(object_id), 0);
        -- delete ur_scheduledareaforurband
        WHEN objectclass_id = 60353 THEN
          dummy_id := citydb.del_ur_scheduledareaforurband(array_agg(object_id), 0);
        -- delete ur_trafficfacility
        WHEN objectclass_id = 60354 THEN
          dummy_id := citydb.del_ur_trafficfacility(array_agg(object_id), 0);
        -- delete ur_openspaceforpublicuse
        WHEN objectclass_id = 60355 THEN
          dummy_id := citydb.del_ur_openspaceforpublicuse(array_agg(object_id), 0);
        -- delete ur_supplyfacility
        WHEN objectclass_id = 60356 THEN
          dummy_id := citydb.del_ur_supplyfacility(array_agg(object_id), 0);
        -- delete ur_treatmentfacility
        WHEN objectclass_id = 60357 THEN
          dummy_id := citydb.del_ur_treatmentfacility(array_agg(object_id), 0);
        -- delete ur_waterway_2
        WHEN objectclass_id = 60358 THEN
          dummy_id := citydb.del_ur_waterway_2(array_agg(object_id), 0);
        -- delete ur_urbanfacility
        WHEN objectclass_id = 60359 THEN
          dummy_id := citydb.del_ur_urbanfacility(array_agg(object_id), 0);
        -- delete ur_urbanfacility
        WHEN objectclass_id = 60360 THEN
          dummy_id := citydb.del_ur_urbanfacility(array_agg(object_id), 0);
        -- delete ur_urbanfacility
        WHEN objectclass_id = 60361 THEN
          dummy_id := citydb.del_ur_urbanfacility(array_agg(object_id), 0);
        -- delete ur_urbanfacility
        WHEN objectclass_id = 60362 THEN
          dummy_id := citydb.del_ur_urbanfacility(array_agg(object_id), 0);
        -- delete ur_collectivehousingfacil
        WHEN objectclass_id = 60363 THEN
          dummy_id := citydb.del_ur_collectivehousingfacil(array_agg(object_id), 0);
        -- delete ur_collectivegovernmentan
        WHEN objectclass_id = 60364 THEN
          dummy_id := citydb.del_ur_collectivegovernmentan(array_agg(object_id), 0);
        -- delete ur_collectiveurbandisaste
        WHEN objectclass_id = 60365 THEN
          dummy_id := citydb.del_ur_collectiveurbandisaste(array_agg(object_id), 0);
        -- delete ur_distributionbusinesspa
        WHEN objectclass_id = 60366 THEN
          dummy_id := citydb.del_ur_distributionbusinesspa(array_agg(object_id), 0);
        -- delete ur_urbanfacilitystipulate
        WHEN objectclass_id = 60367 THEN
          dummy_id := citydb.del_ur_urbanfacilitystipulate(array_agg(object_id), 0);
        -- delete ur_collectivefacilitiesfo
        WHEN objectclass_id = 60368 THEN
          dummy_id := citydb.del_ur_collectivefacilitiesfo(array_agg(object_id), 0);
        -- delete ur_collectivefacilities_2
        WHEN objectclass_id = 60369 THEN
          dummy_id := citydb.del_ur_collectivefacilities_2(array_agg(object_id), 0);
        -- delete ur_collectivefacilities_3
        WHEN objectclass_id = 60370 THEN
          dummy_id := citydb.del_ur_collectivefacilities_3(array_agg(object_id), 0);
        -- delete ur_districtplan
        WHEN objectclass_id = 60371 THEN
          dummy_id := citydb.del_ur_districtplan(array_agg(object_id), 0);
        -- delete ur_disasterpreventionbl_2
        WHEN objectclass_id = 60372 THEN
          dummy_id := citydb.del_ur_disasterpreventionbl_2(array_agg(object_id), 0);
        -- delete ur_historicscenerymainten
        WHEN objectclass_id = 60373 THEN
          dummy_id := citydb.del_ur_historicscenerymainten(array_agg(object_id), 0);
        -- delete ur_roadsidedistrictplan
        WHEN objectclass_id = 60374 THEN
          dummy_id := citydb.del_ur_roadsidedistrictplan(array_agg(object_id), 0);
        -- delete ur_abstractdistrictplan
        WHEN objectclass_id = 60375 THEN
          dummy_id := citydb.del_ur_abstractdistrictplan(array_agg(object_id), 0);
        -- delete ur_districtdevelopmentpla
        WHEN objectclass_id = 60376 THEN
          dummy_id := citydb.del_ur_districtdevelopmentpla(array_agg(object_id), 0);
        -- delete ur_districtdevelopmentpla
        WHEN objectclass_id = 60377 THEN
          dummy_id := citydb.del_ur_districtdevelopmentpla(array_agg(object_id), 0);
        -- delete ur_districtdevelopmentpla
        WHEN objectclass_id = 60378 THEN
          dummy_id := citydb.del_ur_districtdevelopmentpla(array_agg(object_id), 0);
        -- delete ur_roadsidedistrictimprov
        WHEN objectclass_id = 60379 THEN
          dummy_id := citydb.del_ur_roadsidedistrictimprov(array_agg(object_id), 0);
        -- delete ur_ruraldistrictimproveme
        WHEN objectclass_id = 60380 THEN
          dummy_id := citydb.del_ur_ruraldistrictimproveme(array_agg(object_id), 0);
        -- delete ur_zone
        WHEN objectclass_id = 60381 THEN
          dummy_id := citydb.del_ur_zone(array_agg(object_id), 1);
        -- delete ur_zone
        WHEN objectclass_id = 60382 THEN
          dummy_id := citydb.del_ur_zone(array_agg(object_id), 1);
        -- delete ur_specifiedurgenturbanre
        WHEN objectclass_id = 60383 THEN
          dummy_id := citydb.del_ur_specifiedurgenturbanre(array_agg(object_id), 0);
        -- delete ur_urbanfacilitystipulate
        WHEN objectclass_id = 60384 THEN
          dummy_id := citydb.del_ur_urbanfacilitystipulate(array_agg(object_id), 0);
        -- delete ur_urbanfacilitystipulate
        WHEN objectclass_id = 60385 THEN
          dummy_id := citydb.del_ur_urbanfacilitystipulate(array_agg(object_id), 0);
        -- delete ur_urbanfacilitystipulate
        WHEN objectclass_id = 60386 THEN
          dummy_id := citydb.del_ur_urbanfacilitystipulate(array_agg(object_id), 0);
        -- delete ur_urbanfacilitystipulate
        WHEN objectclass_id = 60387 THEN
          dummy_id := citydb.del_ur_urbanfacilitystipulate(array_agg(object_id), 0);
        -- delete ur_urbanfacilitystipulate
        WHEN objectclass_id = 60388 THEN
          dummy_id := citydb.del_ur_urbanfacilitystipulate(array_agg(object_id), 0);
        -- delete ur_urbanfacilitystipulate
        WHEN objectclass_id = 60389 THEN
          dummy_id := citydb.del_ur_urbanfacilitystipulate(array_agg(object_id), 0);
        -- delete ur_urbanfacilitystipulate
        WHEN objectclass_id = 60390 THEN
          dummy_id := citydb.del_ur_urbanfacilitystipulate(array_agg(object_id), 0);
        ELSE
          dummy_id := NULL;
      END CASE;

      IF dummy_id = object_id THEN
        deleted_child_ids := array_append(deleted_child_ids, dummy_id);
      END IF;
    END LOOP;
  END IF;

  -- delete citydb.ur_urbanfunctions
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_urbanfunction t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      lod0multisurface_id,
      lod1multisurface_id,
      lod_1multisurface_id,
      lod_2multisurface_id,
      dataqualityattribute_id
  )
  SELECT
    array_agg(id),
    array_agg(lod0multisurface_id) ||
    array_agg(lod1multisurface_id) ||
    array_agg(lod_1multisurface_id) ||
    array_agg(lod_2multisurface_id),
    array_agg(dataqualityattribute_id)
  INTO
    deleted_ids,
    surface_geometry_ids,
    ur_dataqualityattribute_ids
  FROM
    delete_objects;

  -- delete citydb.surface_geometry(s)
  IF -1 = ALL(surface_geometry_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_surface_geometry(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(surface_geometry_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_dataqualityattribute(s)
  IF -1 = ALL(ur_dataqualityattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_dataqualityattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_dataqualityattribute_ids) AS a_id) a;
  END IF;

  IF $2 <> 1 THEN
    -- delete cityobject
    PERFORM citydb.del_cityobject(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_urbanfunction(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_urbanfunction(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_urbanization(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_urbanizations
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_urbanization t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_urbanfunction
    PERFORM citydb.del_ur_urbanfunction(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_urbanization(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_urbanization(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_urbanparkattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_breakdownofnominalarea_ids bigint[] := '{}';
BEGIN
  -- delete references to ur_breakdownofnominalareas
  WITH del_ur_breakdownofnominalarea_refs AS (
    DELETE FROM
      citydb.ur_urbanpark_to_breakdown t
    USING
      unnest($1) a(a_id)
    WHERE
      t.urbanparkattribute_id = a.a_id
    RETURNING
      t.breakdownofnominalarea_id
  )
  SELECT
    array_agg(breakdownofnominalarea_id)
  INTO
    ur_breakdownofnominalarea_ids
  FROM
    del_ur_breakdownofnominalarea_refs;

  -- delete citydb.ur_breakdownofnominalarea(s)
  IF -1 = ALL(ur_breakdownofnominalarea_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_breakdownofnominalarea(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_breakdownofnominalarea_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_urbanparkattributes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_urbanparkattribute t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_urbanparkattribute(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_urbanparkattribute(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_urbanplanningarea(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_urbanplanningareas
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_urbanplanningarea t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_zone
    PERFORM citydb.del_ur_zone(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_urbanplanningarea(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_urbanplanningarea(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_urbanrapidtransitrailr(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_structuredetails_ids bigint[] := '{}';
BEGIN
  -- delete references to ur_structuredetailss
  WITH del_ur_structuredetails_refs AS (
    DELETE FROM
      citydb.ur_urbanrapi_to_structure t
    USING
      unnest($1) a(a_id)
    WHERE
      t.urbanrapidtransitrailr_id = a.a_id
    RETURNING
      t.structuredetails_id
  )
  SELECT
    array_agg(structuredetails_id)
  INTO
    ur_structuredetails_ids
  FROM
    del_ur_structuredetails_refs;

  -- delete citydb.ur_structuredetails(s)
  IF -1 = ALL(ur_structuredetails_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_structuredetails(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_structuredetails_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_urbanrapidtransitrailrs
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_urbanrapidtransitrailr t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_urbanrapidtransitrailr(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_urbanrapidtransitrailr(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_urbanredevelopmentproj(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_urbanredevelopmentprojs
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_urbanredevelopmentproj t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_urbandevelopmentproj_2
    PERFORM citydb.del_ur_urbandevelopmentproj_2(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_urbanredevelopmentproj(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_urbanredevelopmentproj(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_urbanredevelopmentprom(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_urbanredevelopmentproms
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_urbanredevelopmentprom t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_projectpromotionarea
    PERFORM citydb.del_ur_projectpromotionarea(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_urbanredevelopmentprom(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_urbanredevelopmentprom(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_urbanrenewalproject(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_urbanrenewalprojects
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_urbanrenewalproject t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_urbandevelopmentproj_2
    PERFORM citydb.del_ur_urbandevelopmentproj_2(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_urbanrenewalproject(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_urbanrenewalproject(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_urbanroadattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_structuredetails_ids bigint[] := '{}';
BEGIN
  -- delete references to ur_structuredetailss
  WITH del_ur_structuredetails_refs AS (
    DELETE FROM
      citydb.ur_urbanroad_to_structure t
    USING
      unnest($1) a(a_id)
    WHERE
      t.urbanroadattribute_id = a.a_id
    RETURNING
      t.structuredetails_id
  )
  SELECT
    array_agg(structuredetails_id)
  INTO
    ur_structuredetails_ids
  FROM
    del_ur_structuredetails_refs;

  -- delete citydb.ur_structuredetails(s)
  IF -1 = ALL(ur_structuredetails_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_structuredetails(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_structuredetails_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_urbanroadattributes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_urbanroadattribute t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_urbanroadattribute(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_urbanroadattribute(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_urgenturbanrenewalarea(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  IF $2 <> 2 THEN
    FOR rec IN
      SELECT
        co.id, co.objectclass_id
      FROM
        citydb.cityobject co, unnest($1) a(a_id)
      WHERE
        co.id = a.a_id
    LOOP
      object_id := rec.id::bigint;
      objectclass_id := rec.objectclass_id::integer;
      CASE
        -- delete ur_specifiedurgenturbanre
        WHEN objectclass_id = 60383 THEN
          dummy_id := citydb.del_ur_specifiedurgenturbanre(array_agg(object_id), 1);
        ELSE
          dummy_id := NULL;
      END CASE;

      IF dummy_id = object_id THEN
        deleted_child_ids := array_append(deleted_child_ids, dummy_id);
      END IF;
    END LOOP;
  END IF;

  -- delete citydb.ur_urgenturbanrenewalareas
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_urgenturbanrenewalarea t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_zone
    PERFORM citydb.del_ur_zone(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_urgenturbanrenewalarea(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_urgenturbanrenewalarea(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_usedistrict(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_usedistricts
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_usedistrict t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_districtsandzones
    PERFORM citydb.del_ur_districtsandzones(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_usedistrict(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_usedistrict(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_userdefinedvalue(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_userdefinedvalues
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_userdefinedvalue t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_userdefinedvalue(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_userdefinedvalue(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_utilitylink(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_lengthattribute_ids bigint[] := '{}';
BEGIN
  -- delete references to ur_lengthattributes
  WITH del_ur_lengthattribute_refs AS (
    DELETE FROM
      citydb.ur_utilityli_to_lengthatt t
    USING
      unnest($1) a(a_id)
    WHERE
      t.utilitylink_id = a.a_id
    RETURNING
      t.lengthattribute_id
  )
  SELECT
    array_agg(lengthattribute_id)
  INTO
    ur_lengthattribute_ids
  FROM
    del_ur_lengthattribute_refs;

  -- delete citydb.ur_lengthattribute(s)
  IF -1 = ALL(ur_lengthattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_lengthattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_lengthattribute_ids) AS a_id) a;
  END IF;

  IF $2 <> 2 THEN
    FOR rec IN
      SELECT
        co.id, co.objectclass_id
      FROM
        citydb.cityobject co, unnest($1) a(a_id)
      WHERE
        co.id = a.a_id
    LOOP
      object_id := rec.id::bigint;
      objectclass_id := rec.objectclass_id::integer;
      CASE
        -- delete ur_pipe
        WHEN objectclass_id = 60118 THEN
          dummy_id := citydb.del_ur_pipe(array_agg(object_id), 1);
        -- delete ur_sewerpipe
        WHEN objectclass_id = 60119 THEN
          dummy_id := citydb.del_ur_sewerpipe(array_agg(object_id), 0);
        -- delete ur_pipe
        WHEN objectclass_id = 60120 THEN
          dummy_id := citydb.del_ur_pipe(array_agg(object_id), 1);
        -- delete ur_pipe
        WHEN objectclass_id = 60121 THEN
          dummy_id := citydb.del_ur_pipe(array_agg(object_id), 1);
        -- delete ur_pipe
        WHEN objectclass_id = 60122 THEN
          dummy_id := citydb.del_ur_pipe(array_agg(object_id), 1);
        -- delete ur_cable
        WHEN objectclass_id = 60124 THEN
          dummy_id := citydb.del_ur_cable(array_agg(object_id), 1);
        -- delete ur_cable
        WHEN objectclass_id = 60125 THEN
          dummy_id := citydb.del_ur_cable(array_agg(object_id), 1);
        -- delete ur_cable
        WHEN objectclass_id = 60126 THEN
          dummy_id := citydb.del_ur_cable(array_agg(object_id), 1);
        ELSE
          dummy_id := NULL;
      END CASE;

      IF dummy_id = object_id THEN
        deleted_child_ids := array_append(deleted_child_ids, dummy_id);
      END IF;
    END LOOP;
  END IF;

  -- delete citydb.ur_utilitylinks
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_utilitylink t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_utilitynetworkelement
    PERFORM citydb.del_ur_utilitynetworkelement(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_utilitylink(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_utilitylink(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_utilitynetworkelement(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_offsetdepth_ids bigint[] := '{}';
  ur_thematicshape_ids bigint[] := '{}';
BEGIN
  -- delete references to ur_offsetdepths
  WITH del_ur_offsetdepth_refs AS (
    DELETE FROM
      citydb.ur_utilityne_to_offsetdep t
    USING
      unnest($1) a(a_id)
    WHERE
      t.utilitynetworkelement_id = a.a_id
    RETURNING
      t.offsetdepth_id
  )
  SELECT
    array_agg(offsetdepth_id)
  INTO
    ur_offsetdepth_ids
  FROM
    del_ur_offsetdepth_refs;

  -- delete citydb.ur_offsetdepth(s)
  IF -1 = ALL(ur_offsetdepth_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_offsetdepth(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_offsetdepth_ids) AS a_id) a;
  END IF;

  -- delete references to ur_thematicshapes
  WITH del_ur_thematicshape_refs AS (
    DELETE FROM
      citydb.ur_utilityne_to_thematics t
    USING
      unnest($1) a(a_id)
    WHERE
      t.utilitynetworkelement_id = a.a_id
    RETURNING
      t.thematicshape_id
  )
  SELECT
    array_agg(thematicshape_id)
  INTO
    ur_thematicshape_ids
  FROM
    del_ur_thematicshape_refs;

  -- delete citydb.ur_thematicshape(s)
  IF -1 = ALL(ur_thematicshape_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_thematicshape(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_thematicshape_ids) AS a_id) a;
  END IF;

  IF $2 <> 2 THEN
    FOR rec IN
      SELECT
        co.id, co.objectclass_id
      FROM
        citydb.cityobject co, unnest($1) a(a_id)
      WHERE
        co.id = a.a_id
    LOOP
      object_id := rec.id::bigint;
      objectclass_id := rec.objectclass_id::integer;
      CASE
        -- delete ur_utilitylink
        WHEN objectclass_id = 60111 THEN
          dummy_id := citydb.del_ur_utilitylink(array_agg(object_id), 1);
        -- delete ur_utilitynode
        WHEN objectclass_id = 60113 THEN
          dummy_id := citydb.del_ur_utilitynode(array_agg(object_id), 1);
        -- delete ur_utilitynode
        WHEN objectclass_id = 60114 THEN
          dummy_id := citydb.del_ur_utilitynode(array_agg(object_id), 1);
        -- delete ur_utilitynodecontainer
        WHEN objectclass_id = 60115 THEN
          dummy_id := citydb.del_ur_utilitynodecontainer(array_agg(object_id), 1);
        -- delete ur_utilitynodecontainer
        WHEN objectclass_id = 60116 THEN
          dummy_id := citydb.del_ur_utilitynodecontainer(array_agg(object_id), 1);
        -- delete ur_utilitynodecontainer
        WHEN objectclass_id = 60117 THEN
          dummy_id := citydb.del_ur_utilitynodecontainer(array_agg(object_id), 1);
        -- delete ur_pipe
        WHEN objectclass_id = 60118 THEN
          dummy_id := citydb.del_ur_pipe(array_agg(object_id), 0);
        -- delete ur_sewerpipe
        WHEN objectclass_id = 60119 THEN
          dummy_id := citydb.del_ur_sewerpipe(array_agg(object_id), 0);
        -- delete ur_pipe
        WHEN objectclass_id = 60120 THEN
          dummy_id := citydb.del_ur_pipe(array_agg(object_id), 0);
        -- delete ur_pipe
        WHEN objectclass_id = 60121 THEN
          dummy_id := citydb.del_ur_pipe(array_agg(object_id), 0);
        -- delete ur_pipe
        WHEN objectclass_id = 60122 THEN
          dummy_id := citydb.del_ur_pipe(array_agg(object_id), 0);
        -- delete ur_utilitylink
        WHEN objectclass_id = 60123 THEN
          dummy_id := citydb.del_ur_utilitylink(array_agg(object_id), 1);
        -- delete ur_cable
        WHEN objectclass_id = 60124 THEN
          dummy_id := citydb.del_ur_cable(array_agg(object_id), 0);
        -- delete ur_cable
        WHEN objectclass_id = 60125 THEN
          dummy_id := citydb.del_ur_cable(array_agg(object_id), 0);
        -- delete ur_cable
        WHEN objectclass_id = 60126 THEN
          dummy_id := citydb.del_ur_cable(array_agg(object_id), 0);
        ELSE
          dummy_id := NULL;
      END CASE;

      IF dummy_id = object_id THEN
        deleted_child_ids := array_append(deleted_child_ids, dummy_id);
      END IF;
    END LOOP;
  END IF;

  -- delete citydb.ur_utilitynetworkelements
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_utilitynetworkelement t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete city_furniture
    PERFORM citydb.del_city_furniture(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_utilitynetworkelement(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_utilitynetworkelement(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_utilitynode(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_utilitynodes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_utilitynode t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_utilitynetworkelement
    PERFORM citydb.del_ur_utilitynetworkelement(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_utilitynode(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_utilitynode(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_utilitynodecontainer(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_utilitynodecontainers
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_utilitynodecontainer t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_utilitynetworkelement
    PERFORM citydb.del_ur_utilitynetworkelement(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_utilitynodecontainer(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_utilitynodecontainer(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_valuebycodes(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_valuebycodess
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_valuebycodes t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_valuebycodes(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_valuebycodes(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_vehicleterminalattribu(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_vehicleterminalattribus
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_vehicleterminalattribu t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_vehicleterminalattribu(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_vehicleterminalattribu(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_verticalcurvetype(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_verticalcurvetypes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_verticalcurvetype t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_verticalcurvetype(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_verticalcurvetype(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_waterbody(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_dmattribute_ids bigint[] := '{}';
  ur_facilityattribute_ids bigint[] := '{}';
  ur_floodingriskattribute_ids bigint[] := '{}';
  ur_keyvaluepairattribute_ids bigint[] := '{}';
  ur_dataqualityattribute_ids bigint[] := '{}';
  ur_facilityidattribute_ids bigint[] := '{}';
  ur_facilitytypeattribute_ids bigint[] := '{}';
  ur_waterbodydetailattribu_ids bigint[] := '{}';
BEGIN
  -- delete references to ur_dmattributes
  WITH del_ur_dmattribute_refs AS (
    DELETE FROM
      citydb.ur_waterbody_to_dmattribu t
    USING
      unnest($1) a(a_id)
    WHERE
      t.waterbody_id = a.a_id
    RETURNING
      t.dmattribute_id
  )
  SELECT
    array_agg(dmattribute_id)
  INTO
    ur_dmattribute_ids
  FROM
    del_ur_dmattribute_refs;

  -- delete citydb.ur_dmattribute(s)
  IF -1 = ALL(ur_dmattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_dmattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_dmattribute_ids) AS a_id) a;
  END IF;

  -- delete references to ur_facilityattributes
  WITH del_ur_facilityattribute_refs AS (
    DELETE FROM
      citydb.ur_waterbody_to_facilitya t
    USING
      unnest($1) a(a_id)
    WHERE
      t.waterbody_id = a.a_id
    RETURNING
      t.facilityattribute_id
  )
  SELECT
    array_agg(facilityattribute_id)
  INTO
    ur_facilityattribute_ids
  FROM
    del_ur_facilityattribute_refs;

  -- delete citydb.ur_facilityattribute(s)
  IF -1 = ALL(ur_facilityattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_facilityattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_facilityattribute_ids) AS a_id) a;
  END IF;

  -- delete references to ur_floodingriskattributes
  WITH del_ur_floodingriskattribute_refs AS (
    DELETE FROM
      citydb.ur_waterbody_to_floodingr t
    USING
      unnest($1) a(a_id)
    WHERE
      t.waterbody_id = a.a_id
    RETURNING
      t.floodingriskattribute_id
  )
  SELECT
    array_agg(floodingriskattribute_id)
  INTO
    ur_floodingriskattribute_ids
  FROM
    del_ur_floodingriskattribute_refs;

  -- delete citydb.ur_floodingriskattribute(s)
  IF -1 = ALL(ur_floodingriskattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_floodingriskattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_floodingriskattribute_ids) AS a_id) a;
  END IF;

  -- delete references to ur_keyvaluepairattributes
  WITH del_ur_keyvaluepairattribute_refs AS (
    DELETE FROM
      citydb.ur_waterbody_to_keyvaluep t
    USING
      unnest($1) a(a_id)
    WHERE
      t.waterbody_id = a.a_id
    RETURNING
      t.keyvaluepairattribute_id
  )
  SELECT
    array_agg(keyvaluepairattribute_id)
  INTO
    ur_keyvaluepairattribute_ids
  FROM
    del_ur_keyvaluepairattribute_refs;

  -- delete citydb.ur_keyvaluepairattribute(s)
  IF -1 = ALL(ur_keyvaluepairattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_keyvaluepairattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_keyvaluepairattribute_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_waterbodys
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_waterbody t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      wtrdataqualityattribute_id,
      wtrfacilityidattribute_id,
      wtrfacilitytypeattribute_id,
      waterbodydetailattribute_id
  )
  SELECT
    array_agg(id),
    array_agg(wtrdataqualityattribute_id),
    array_agg(wtrfacilityidattribute_id),
    array_agg(wtrfacilitytypeattribute_id),
    array_agg(waterbodydetailattribute_id)
  INTO
    deleted_ids,
    ur_dataqualityattribute_ids,
    ur_facilityidattribute_ids,
    ur_facilitytypeattribute_ids,
    ur_waterbodydetailattribu_ids
  FROM
    delete_objects;

  -- delete citydb.ur_dataqualityattribute(s)
  IF -1 = ALL(ur_dataqualityattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_dataqualityattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_dataqualityattribute_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_facilityidattribute(s)
  IF -1 = ALL(ur_facilityidattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_facilityidattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_facilityidattribute_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_facilitytypeattribute(s)
  IF -1 = ALL(ur_facilitytypeattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_facilitytypeattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_facilitytypeattribute_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_waterbodydetailattribu(s)
  IF -1 = ALL(ur_waterbodydetailattribu_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_waterbodydetailattribu(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_waterbodydetailattribu_ids) AS a_id) a;
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_waterbody(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_waterbody(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_waterbodydetailattribu(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_waterbodydetailattribus
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_waterbodydetailattribu t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_waterbodydetailattribu(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_waterbodydetailattribu(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_waterway(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_waterwaydetailattribut_ids bigint[] := '{}';
BEGIN
  -- delete citydb.ur_waterways
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_waterway t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      waterwaydetailattribute_id
  )
  SELECT
    array_agg(id),
    array_agg(waterwaydetailattribute_id)
  INTO
    deleted_ids,
    ur_waterwaydetailattribut_ids
  FROM
    delete_objects;

  -- delete citydb.ur_waterwaydetailattribut(s)
  IF -1 = ALL(ur_waterwaydetailattribut_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_waterwaydetailattribut(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_waterwaydetailattribut_ids) AS a_id) a;
  END IF;

  IF $2 <> 1 THEN
    -- delete transportation_complex
    PERFORM citydb.del_transportation_complex(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_waterway(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_waterway(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_waterway_2(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_waterway_2s
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_waterway_2 t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_urbanfacility
    PERFORM citydb.del_ur_urbanfacility(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_waterway_2(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_waterway_2(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_waterwaydetailattribut(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_waterwaydetailattributs
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_waterwaydetailattribut t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_waterwaydetailattribut(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_waterwaydetailattribut(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_waterworksattribute(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_waterworksattributes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_waterworksattribute t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_waterworksattribute(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_waterworksattribute(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_weatherobservation(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_weatherobservationtype_ids bigint[] := '{}';
BEGIN
  -- delete references to ur_weatherobservationtypes
  WITH del_ur_weatherobservationtype_refs AS (
    DELETE FROM
      citydb.ur_weatherob_to_weatherob t
    USING
      unnest($1) a(a_id)
    WHERE
      t.weatherobservation_id = a.a_id
    RETURNING
      t.weatherobservationtype_id
  )
  SELECT
    array_agg(weatherobservationtype_id)
  INTO
    ur_weatherobservationtype_ids
  FROM
    del_ur_weatherobservationtype_refs;

  -- delete citydb.ur_weatherobservationtype(s)
  IF -1 = ALL(ur_weatherobservationtype_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_weatherobservationtype(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_weatherobservationtype_ids) AS a_id) a;
  END IF;

  -- delete citydb.ur_weatherobservations
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_weatherobservation t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_urbanfunction
    PERFORM citydb.del_ur_urbanfunction(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_weatherobservation(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_weatherobservation(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_weatherobservationtype(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_weatherobservationtypes
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_weatherobservationtype t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_weatherobservationtype(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_weatherobservationtype(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_zonaldisasterpreventio(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
BEGIN
  -- delete citydb.ur_zonaldisasterpreventios
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_zonaldisasterpreventio t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id
  )
  SELECT
    array_agg(id)
  INTO
    deleted_ids
  FROM
    delete_objects;

  IF $2 <> 1 THEN
    -- delete ur_zone
    PERFORM citydb.del_ur_zone(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_zonaldisasterpreventio(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_zonaldisasterpreventio(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_zone(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  ur_boundary_ids bigint[] := '{}';
  ur_urbanparkattribute_ids bigint[] := '{}';
BEGIN
  -- delete references to ur_boundarys
  WITH del_ur_boundary_refs AS (
    DELETE FROM
      citydb.ur_zone_to_boundary t
    USING
      unnest($1) a(a_id)
    WHERE
      t.zone_id = a.a_id
    RETURNING
      t.boundary_id
  )
  SELECT
    array_agg(boundary_id)
  INTO
    ur_boundary_ids
  FROM
    del_ur_boundary_refs;

  -- delete citydb.ur_boundary(s)
  IF -1 = ALL(ur_boundary_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_boundary(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_boundary_ids) AS a_id) a;
  END IF;

  IF $2 <> 2 THEN
    FOR rec IN
      SELECT
        co.id, co.objectclass_id
      FROM
        citydb.cityobject co, unnest($1) a(a_id)
      WHERE
        co.id = a.a_id
    LOOP
      object_id := rec.id::bigint;
      objectclass_id := rec.objectclass_id::integer;
      CASE
        -- delete ur_urbanplanningarea
        WHEN objectclass_id = 60283 THEN
          dummy_id := citydb.del_ur_urbanplanningarea(array_agg(object_id), 1);
        -- delete ur_quasiurbanplanningarea
        WHEN objectclass_id = 60284 THEN
          dummy_id := citydb.del_ur_quasiurbanplanningarea(array_agg(object_id), 1);
        -- delete ur_areaclassification
        WHEN objectclass_id = 60285 THEN
          dummy_id := citydb.del_ur_areaclassification(array_agg(object_id), 1);
        -- delete ur_districtsandzones
        WHEN objectclass_id = 60286 THEN
          dummy_id := citydb.del_ur_districtsandzones(array_agg(object_id), 1);
        -- delete ur_projectpromotionarea
        WHEN objectclass_id = 60287 THEN
          dummy_id := citydb.del_ur_projectpromotionarea(array_agg(object_id), 1);
        -- delete ur_urbandisasterrecoveryp
        WHEN objectclass_id = 60289 THEN
          dummy_id := citydb.del_ur_urbandisasterrecoveryp(array_agg(object_id), 1);
        -- delete ur_urbandevelopmentproj_2
        WHEN objectclass_id = 60290 THEN
          dummy_id := citydb.del_ur_urbandevelopmentproj_2(array_agg(object_id), 1);
        -- delete ur_scheduledareaforurband
        WHEN objectclass_id = 60291 THEN
          dummy_id := citydb.del_ur_scheduledareaforurband(array_agg(object_id), 1);
        -- delete ur_urbanfacility
        WHEN objectclass_id = 60292 THEN
          dummy_id := citydb.del_ur_urbanfacility(array_agg(object_id), 1);
        -- delete ur_abstractdistrictplan
        WHEN objectclass_id = 60293 THEN
          dummy_id := citydb.del_ur_abstractdistrictplan(array_agg(object_id), 1);
        -- delete ur_districtdevelopmentpla
        WHEN objectclass_id = 60294 THEN
          dummy_id := citydb.del_ur_districtdevelopmentpla(array_agg(object_id), 1);
        -- delete ur_district
        WHEN objectclass_id = 60295 THEN
          dummy_id := citydb.del_ur_district(array_agg(object_id), 1);
        -- delete ur_zonaldisasterpreventio
        WHEN objectclass_id = 60297 THEN
          dummy_id := citydb.del_ur_zonaldisasterpreventio(array_agg(object_id), 1);
        -- delete ur_urgenturbanrenewalarea
        WHEN objectclass_id = 60299 THEN
          dummy_id := citydb.del_ur_urgenturbanrenewalarea(array_agg(object_id), 1);
        -- delete ur_privateurbanrenewalpro
        WHEN objectclass_id = 60300 THEN
          dummy_id := citydb.del_ur_privateurbanrenewalpro(array_agg(object_id), 1);
        -- delete ur_globalhubcitydevelopme
        WHEN objectclass_id = 60301 THEN
          dummy_id := citydb.del_ur_globalhubcitydevelopme(array_agg(object_id), 1);
        -- delete ur_agreement
        WHEN objectclass_id = 60302 THEN
          dummy_id := citydb.del_ur_agreement(array_agg(object_id), 1);
        -- delete ur_sedimentdisasterpronea
        WHEN objectclass_id = 60304 THEN
          dummy_id := citydb.del_ur_sedimentdisasterpronea(array_agg(object_id), 1);
        -- delete ur_usedistrict
        WHEN objectclass_id = 60309 THEN
          dummy_id := citydb.del_ur_usedistrict(array_agg(object_id), 0);
        -- delete ur_specialusedistrict
        WHEN objectclass_id = 60310 THEN
          dummy_id := citydb.del_ur_specialusedistrict(array_agg(object_id), 0);
        -- delete ur_specialuserestrictiond
        WHEN objectclass_id = 60311 THEN
          dummy_id := citydb.del_ur_specialuserestrictiond(array_agg(object_id), 0);
        -- delete ur_exceptionalfloorareara
        WHEN objectclass_id = 60312 THEN
          dummy_id := citydb.del_ur_exceptionalfloorareara(array_agg(object_id), 0);
        -- delete ur_highriseresidentialatt
        WHEN objectclass_id = 60313 THEN
          dummy_id := citydb.del_ur_highriseresidentialatt(array_agg(object_id), 0);
        -- delete ur_heightcontroldistrict
        WHEN objectclass_id = 60314 THEN
          dummy_id := citydb.del_ur_heightcontroldistrict(array_agg(object_id), 0);
        -- delete ur_highlevelusedistrict
        WHEN objectclass_id = 60315 THEN
          dummy_id := citydb.del_ur_highlevelusedistrict(array_agg(object_id), 0);
        -- delete ur_specifiedblock
        WHEN objectclass_id = 60316 THEN
          dummy_id := citydb.del_ur_specifiedblock(array_agg(object_id), 0);
        -- delete ur_specialurbanrenaissanc
        WHEN objectclass_id = 60317 THEN
          dummy_id := citydb.del_ur_specialurbanrenaissanc(array_agg(object_id), 0);
        -- delete ur_districtsandzones
        WHEN objectclass_id = 60318 THEN
          dummy_id := citydb.del_ur_districtsandzones(array_agg(object_id), 1);
        -- delete ur_residentialenvironment
        WHEN objectclass_id = 60319 THEN
          dummy_id := citydb.del_ur_residentialenvironment(array_agg(object_id), 0);
        -- delete ur_specialuseattractiondi
        WHEN objectclass_id = 60320 THEN
          dummy_id := citydb.del_ur_specialuseattractiondi(array_agg(object_id), 0);
        -- delete ur_districtsandzones
        WHEN objectclass_id = 60321 THEN
          dummy_id := citydb.del_ur_districtsandzones(array_agg(object_id), 1);
        -- delete ur_specifieddisasterpreve
        WHEN objectclass_id = 60322 THEN
          dummy_id := citydb.del_ur_specifieddisasterpreve(array_agg(object_id), 0);
        -- delete ur_landscapezone
        WHEN objectclass_id = 60323 THEN
          dummy_id := citydb.del_ur_landscapezone(array_agg(object_id), 0);
        -- delete ur_scenicdistrict
        WHEN objectclass_id = 60324 THEN
          dummy_id := citydb.del_ur_scenicdistrict(array_agg(object_id), 0);
        -- delete ur_districtsandzones
        WHEN objectclass_id = 60325 THEN
          dummy_id := citydb.del_ur_districtsandzones(array_agg(object_id), 1);
        -- delete ur_portzone
        WHEN objectclass_id = 60326 THEN
          dummy_id := citydb.del_ur_portzone(array_agg(object_id), 0);
        -- delete ur_districtsandzones
        WHEN objectclass_id = 60327 THEN
          dummy_id := citydb.del_ur_districtsandzones(array_agg(object_id), 1);
        -- delete ur_districtsandzones
        WHEN objectclass_id = 60328 THEN
          dummy_id := citydb.del_ur_districtsandzones(array_agg(object_id), 1);
        -- delete ur_districtsandzones
        WHEN objectclass_id = 60329 THEN
          dummy_id := citydb.del_ur_districtsandzones(array_agg(object_id), 1);
        -- delete ur_specialgreenspaceconse
        WHEN objectclass_id = 60330 THEN
          dummy_id := citydb.del_ur_specialgreenspaceconse(array_agg(object_id), 0);
        -- delete ur_treeplantingdistrict
        WHEN objectclass_id = 60331 THEN
          dummy_id := citydb.del_ur_treeplantingdistrict(array_agg(object_id), 0);
        -- delete ur_distributionbusinesszo
        WHEN objectclass_id = 60332 THEN
          dummy_id := citydb.del_ur_distributionbusinesszo(array_agg(object_id), 0);
        -- delete ur_productivegreenzone
        WHEN objectclass_id = 60333 THEN
          dummy_id := citydb.del_ur_productivegreenzone(array_agg(object_id), 0);
        -- delete ur_districtsandzones
        WHEN objectclass_id = 60334 THEN
          dummy_id := citydb.del_ur_districtsandzones(array_agg(object_id), 1);
        -- delete ur_districtsandzones
        WHEN objectclass_id = 60335 THEN
          dummy_id := citydb.del_ur_districtsandzones(array_agg(object_id), 1);
        -- delete ur_urbanredevelopmentprom
        WHEN objectclass_id = 60336 THEN
          dummy_id := citydb.del_ur_urbanredevelopmentprom(array_agg(object_id), 0);
        -- delete ur_projectpromotionarea
        WHEN objectclass_id = 60337 THEN
          dummy_id := citydb.del_ur_projectpromotionarea(array_agg(object_id), 1);
        -- delete ur_projectpromotionarea
        WHEN objectclass_id = 60338 THEN
          dummy_id := citydb.del_ur_projectpromotionarea(array_agg(object_id), 1);
        -- delete ur_projectpromotionarea
        WHEN objectclass_id = 60339 THEN
          dummy_id := citydb.del_ur_projectpromotionarea(array_agg(object_id), 1);
        -- delete ur_landreadjustmentprojec
        WHEN objectclass_id = 60340 THEN
          dummy_id := citydb.del_ur_landreadjustmentprojec(array_agg(object_id), 0);
        -- delete ur_newhousingandurbandeve
        WHEN objectclass_id = 60341 THEN
          dummy_id := citydb.del_ur_newhousingandurbandeve(array_agg(object_id), 0);
        -- delete ur_industrialparkdevelopm
        WHEN objectclass_id = 60342 THEN
          dummy_id := citydb.del_ur_industrialparkdevelopm(array_agg(object_id), 0);
        -- delete ur_urbanredevelopmentproj
        WHEN objectclass_id = 60343 THEN
          dummy_id := citydb.del_ur_urbanredevelopmentproj(array_agg(object_id), 0);
        -- delete ur_newurbaninfrastructure
        WHEN objectclass_id = 60344 THEN
          dummy_id := citydb.del_ur_newurbaninfrastructure(array_agg(object_id), 0);
        -- delete ur_residentialblockconstr
        WHEN objectclass_id = 60345 THEN
          dummy_id := citydb.del_ur_residentialblockconstr(array_agg(object_id), 0);
        -- delete ur_disasterpreventionbloc
        WHEN objectclass_id = 60346 THEN
          dummy_id := citydb.del_ur_disasterpreventionbloc(array_agg(object_id), 0);
        -- delete ur_urbanrenewalproject
        WHEN objectclass_id = 60347 THEN
          dummy_id := citydb.del_ur_urbanrenewalproject(array_agg(object_id), 0);
        -- delete ur_scheduledareaforurband
        WHEN objectclass_id = 60348 THEN
          dummy_id := citydb.del_ur_scheduledareaforurband(array_agg(object_id), 1);
        -- delete ur_scheduledareaforurband
        WHEN objectclass_id = 60349 THEN
          dummy_id := citydb.del_ur_scheduledareaforurband(array_agg(object_id), 1);
        -- delete ur_scheduledareaforurband
        WHEN objectclass_id = 60350 THEN
          dummy_id := citydb.del_ur_scheduledareaforurband(array_agg(object_id), 1);
        -- delete ur_scheduledareaforurband
        WHEN objectclass_id = 60351 THEN
          dummy_id := citydb.del_ur_scheduledareaforurband(array_agg(object_id), 1);
        -- delete ur_scheduledareaforurband
        WHEN objectclass_id = 60352 THEN
          dummy_id := citydb.del_ur_scheduledareaforurband(array_agg(object_id), 1);
        -- delete ur_scheduledareaforurband
        WHEN objectclass_id = 60353 THEN
          dummy_id := citydb.del_ur_scheduledareaforurband(array_agg(object_id), 1);
        -- delete ur_trafficfacility
        WHEN objectclass_id = 60354 THEN
          dummy_id := citydb.del_ur_trafficfacility(array_agg(object_id), 0);
        -- delete ur_openspaceforpublicuse
        WHEN objectclass_id = 60355 THEN
          dummy_id := citydb.del_ur_openspaceforpublicuse(array_agg(object_id), 0);
        -- delete ur_supplyfacility
        WHEN objectclass_id = 60356 THEN
          dummy_id := citydb.del_ur_supplyfacility(array_agg(object_id), 0);
        -- delete ur_treatmentfacility
        WHEN objectclass_id = 60357 THEN
          dummy_id := citydb.del_ur_treatmentfacility(array_agg(object_id), 0);
        -- delete ur_waterway_2
        WHEN objectclass_id = 60358 THEN
          dummy_id := citydb.del_ur_waterway_2(array_agg(object_id), 0);
        -- delete ur_urbanfacility
        WHEN objectclass_id = 60359 THEN
          dummy_id := citydb.del_ur_urbanfacility(array_agg(object_id), 1);
        -- delete ur_urbanfacility
        WHEN objectclass_id = 60360 THEN
          dummy_id := citydb.del_ur_urbanfacility(array_agg(object_id), 1);
        -- delete ur_urbanfacility
        WHEN objectclass_id = 60361 THEN
          dummy_id := citydb.del_ur_urbanfacility(array_agg(object_id), 1);
        -- delete ur_urbanfacility
        WHEN objectclass_id = 60362 THEN
          dummy_id := citydb.del_ur_urbanfacility(array_agg(object_id), 1);
        -- delete ur_collectivehousingfacil
        WHEN objectclass_id = 60363 THEN
          dummy_id := citydb.del_ur_collectivehousingfacil(array_agg(object_id), 0);
        -- delete ur_collectivegovernmentan
        WHEN objectclass_id = 60364 THEN
          dummy_id := citydb.del_ur_collectivegovernmentan(array_agg(object_id), 0);
        -- delete ur_collectiveurbandisaste
        WHEN objectclass_id = 60365 THEN
          dummy_id := citydb.del_ur_collectiveurbandisaste(array_agg(object_id), 0);
        -- delete ur_distributionbusinesspa
        WHEN objectclass_id = 60366 THEN
          dummy_id := citydb.del_ur_distributionbusinesspa(array_agg(object_id), 0);
        -- delete ur_urbanfacilitystipulate
        WHEN objectclass_id = 60367 THEN
          dummy_id := citydb.del_ur_urbanfacilitystipulate(array_agg(object_id), 0);
        -- delete ur_collectivefacilitiesfo
        WHEN objectclass_id = 60368 THEN
          dummy_id := citydb.del_ur_collectivefacilitiesfo(array_agg(object_id), 0);
        -- delete ur_collectivefacilities_2
        WHEN objectclass_id = 60369 THEN
          dummy_id := citydb.del_ur_collectivefacilities_2(array_agg(object_id), 0);
        -- delete ur_collectivefacilities_3
        WHEN objectclass_id = 60370 THEN
          dummy_id := citydb.del_ur_collectivefacilities_3(array_agg(object_id), 0);
        -- delete ur_districtplan
        WHEN objectclass_id = 60371 THEN
          dummy_id := citydb.del_ur_districtplan(array_agg(object_id), 0);
        -- delete ur_disasterpreventionbl_2
        WHEN objectclass_id = 60372 THEN
          dummy_id := citydb.del_ur_disasterpreventionbl_2(array_agg(object_id), 0);
        -- delete ur_historicscenerymainten
        WHEN objectclass_id = 60373 THEN
          dummy_id := citydb.del_ur_historicscenerymainten(array_agg(object_id), 0);
        -- delete ur_roadsidedistrictplan
        WHEN objectclass_id = 60374 THEN
          dummy_id := citydb.del_ur_roadsidedistrictplan(array_agg(object_id), 0);
        -- delete ur_abstractdistrictplan
        WHEN objectclass_id = 60375 THEN
          dummy_id := citydb.del_ur_abstractdistrictplan(array_agg(object_id), 1);
        -- delete ur_districtdevelopmentpla
        WHEN objectclass_id = 60376 THEN
          dummy_id := citydb.del_ur_districtdevelopmentpla(array_agg(object_id), 1);
        -- delete ur_districtdevelopmentpla
        WHEN objectclass_id = 60377 THEN
          dummy_id := citydb.del_ur_districtdevelopmentpla(array_agg(object_id), 1);
        -- delete ur_districtdevelopmentpla
        WHEN objectclass_id = 60378 THEN
          dummy_id := citydb.del_ur_districtdevelopmentpla(array_agg(object_id), 1);
        -- delete ur_roadsidedistrictimprov
        WHEN objectclass_id = 60379 THEN
          dummy_id := citydb.del_ur_roadsidedistrictimprov(array_agg(object_id), 0);
        -- delete ur_ruraldistrictimproveme
        WHEN objectclass_id = 60380 THEN
          dummy_id := citydb.del_ur_ruraldistrictimproveme(array_agg(object_id), 0);
        -- delete ur_specifiedurgenturbanre
        WHEN objectclass_id = 60383 THEN
          dummy_id := citydb.del_ur_specifiedurgenturbanre(array_agg(object_id), 0);
        -- delete ur_urbanfacilitystipulate
        WHEN objectclass_id = 60384 THEN
          dummy_id := citydb.del_ur_urbanfacilitystipulate(array_agg(object_id), 0);
        -- delete ur_urbanfacilitystipulate
        WHEN objectclass_id = 60385 THEN
          dummy_id := citydb.del_ur_urbanfacilitystipulate(array_agg(object_id), 0);
        -- delete ur_urbanfacilitystipulate
        WHEN objectclass_id = 60386 THEN
          dummy_id := citydb.del_ur_urbanfacilitystipulate(array_agg(object_id), 0);
        -- delete ur_urbanfacilitystipulate
        WHEN objectclass_id = 60387 THEN
          dummy_id := citydb.del_ur_urbanfacilitystipulate(array_agg(object_id), 0);
        -- delete ur_urbanfacilitystipulate
        WHEN objectclass_id = 60388 THEN
          dummy_id := citydb.del_ur_urbanfacilitystipulate(array_agg(object_id), 0);
        -- delete ur_urbanfacilitystipulate
        WHEN objectclass_id = 60389 THEN
          dummy_id := citydb.del_ur_urbanfacilitystipulate(array_agg(object_id), 0);
        -- delete ur_urbanfacilitystipulate
        WHEN objectclass_id = 60390 THEN
          dummy_id := citydb.del_ur_urbanfacilitystipulate(array_agg(object_id), 0);
        ELSE
          dummy_id := NULL;
      END CASE;

      IF dummy_id = object_id THEN
        deleted_child_ids := array_append(deleted_child_ids, dummy_id);
      END IF;
    END LOOP;
  END IF;

  -- delete citydb.ur_zones
  WITH delete_objects AS (
    DELETE FROM
      citydb.ur_zone t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      urbanparkattribute_id
  )
  SELECT
    array_agg(id),
    array_agg(urbanparkattribute_id)
  INTO
    deleted_ids,
    ur_urbanparkattribute_ids
  FROM
    delete_objects;

  -- delete citydb.ur_urbanparkattribute(s)
  IF -1 = ALL(ur_urbanparkattribute_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_ur_urbanparkattribute(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(ur_urbanparkattribute_ids) AS a_id) a;
  END IF;

  IF $2 <> 1 THEN
    -- delete ur_urbanfunction
    PERFORM citydb.del_ur_urbanfunction(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_ur_zone(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_ur_zone(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_waterbody(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  waterboundary_surface_ids bigint[] := '{}';
  surface_geometry_ids bigint[] := '{}';
BEGIN
  -- delete references to waterboundary_surfaces
  WITH del_waterboundary_surface_refs AS (
    DELETE FROM
      citydb.waterbod_to_waterbnd_srf t
    USING
      unnest($1) a(a_id)
    WHERE
      t.waterbody_id = a.a_id
    RETURNING
      t.waterboundary_surface_id
  )
  SELECT
    array_agg(waterboundary_surface_id)
  INTO
    waterboundary_surface_ids
  FROM
    del_waterboundary_surface_refs;

  -- delete citydb.waterboundary_surface(s)
  IF -1 = ALL(waterboundary_surface_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_waterboundary_surface(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(waterboundary_surface_ids) AS a_id) a
    LEFT JOIN
      citydb.waterbod_to_waterbnd_srf n1
      ON n1.waterboundary_surface_id  = a.a_id
    WHERE n1.waterboundary_surface_id IS NULL;
  END IF;

  -- delete ur_waterbodys
  PERFORM citydb.del_ur_waterbody($1, 1);

  -- delete citydb.waterbodys
  WITH delete_objects AS (
    DELETE FROM
      citydb.waterbody t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      lod0_multi_surface_id,
      lod1_multi_surface_id,
      lod1_solid_id,
      lod2_solid_id,
      lod3_solid_id,
      lod4_solid_id
  )
  SELECT
    array_agg(id),
    array_agg(lod0_multi_surface_id) ||
    array_agg(lod1_multi_surface_id) ||
    array_agg(lod1_solid_id) ||
    array_agg(lod2_solid_id) ||
    array_agg(lod3_solid_id) ||
    array_agg(lod4_solid_id)
  INTO
    deleted_ids,
    surface_geometry_ids
  FROM
    delete_objects;

  -- delete citydb.surface_geometry(s)
  IF -1 = ALL(surface_geometry_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_surface_geometry(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(surface_geometry_ids) AS a_id) a;
  END IF;

  IF $2 <> 1 THEN
    -- delete cityobject
    PERFORM citydb.del_cityobject(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_waterbody(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_waterbody(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_waterboundary_surface(bigint[], caller INTEGER DEFAULT 0) RETURNS SETOF bigint AS
$body$
DECLARE
  deleted_ids bigint[] := '{}';
  dummy_id bigint;
  deleted_child_ids bigint[] := '{}';
  object_id bigint;
  objectclass_id integer;
  rec RECORD;
  surface_geometry_ids bigint[] := '{}';
BEGIN
  -- delete citydb.waterboundary_surfaces
  WITH delete_objects AS (
    DELETE FROM
      citydb.waterboundary_surface t
    USING
      unnest($1) a(a_id)
    WHERE
      t.id = a.a_id
    RETURNING
      id,
      lod2_surface_id,
      lod3_surface_id,
      lod4_surface_id
  )
  SELECT
    array_agg(id),
    array_agg(lod2_surface_id) ||
    array_agg(lod3_surface_id) ||
    array_agg(lod4_surface_id)
  INTO
    deleted_ids,
    surface_geometry_ids
  FROM
    delete_objects;

  -- delete citydb.surface_geometry(s)
  IF -1 = ALL(surface_geometry_ids) IS NOT NULL THEN
    PERFORM
      citydb.del_surface_geometry(array_agg(a.a_id))
    FROM
      (SELECT DISTINCT unnest(surface_geometry_ids) AS a_id) a;
  END IF;

  IF $2 <> 1 THEN
    -- delete cityobject
    PERFORM citydb.del_cityobject(deleted_ids, 2);
  END IF;

  IF array_length(deleted_child_ids, 1) > 0 THEN
    deleted_ids := deleted_child_ids;
  END IF;

  RETURN QUERY
    SELECT unnest(deleted_ids);
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------

CREATE OR REPLACE FUNCTION citydb.del_waterboundary_surface(pid bigint) RETURNS bigint AS
$body$
DECLARE
  deleted_id bigint;
BEGIN
  deleted_id := citydb.del_waterboundary_surface(ARRAY[pid]);
  RETURN deleted_id;
END;
$body$
LANGUAGE plpgsql STRICT;
------------------------------------------


