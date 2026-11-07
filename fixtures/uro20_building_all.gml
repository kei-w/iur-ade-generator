<?xml version="1.0" encoding="UTF-8"?>
<!-- Synthetic i-UR 2.0 fixture: one building using every uro building attribute field. -->
<core:CityModel xmlns:core="http://www.opengis.net/citygml/2.0" xmlns:bldg="http://www.opengis.net/citygml/building/2.0" xmlns:gml="http://www.opengis.net/gml" xmlns:uro="https://www.geospatial.jp/iur/uro/2.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="https://www.geospatial.jp/iur/uro/2.0 ../_data/hachioji/13201_hachioji-shi_2020_citygml_4_2_op/schemas/iur/uro/2.0/urbanObject.xsd http://www.opengis.net/citygml/2.0 http://schemas.opengis.net/citygml/2.0/cityGMLBase.xsd http://www.opengis.net/citygml/building/2.0 http://schemas.opengis.net/citygml/building/2.0/building.xsd">
	<gml:boundedBy>
		<gml:Envelope srsName="http://www.opengis.net/def/crs/EPSG/0/6697" srsDimension="3">
			<gml:lowerCorner>35.0 139.0 0.0</gml:lowerCorner>
			<gml:upperCorner>35.001 139.001 10.0</gml:upperCorner>
		</gml:Envelope>
	</gml:boundedBy>
	<core:cityObjectMember>
		<bldg:Building gml:id="bldg_fixture_all">
			<core:creationDate>2024-03-15</core:creationDate>
			<bldg:class codeSpace="../../codelists/Building_class.xml">3001</bldg:class>
			<bldg:usage codeSpace="../../codelists/Building_usage.xml">411</bldg:usage>
			<bldg:measuredHeight uom="m">9.5</bldg:measuredHeight>
			<bldg:storeysAboveGround>3</bldg:storeysAboveGround>
			<bldg:lod1Solid>
				<gml:Solid>
					<gml:exterior>
						<gml:CompositeSurface>
							<gml:surfaceMember>
								<gml:Polygon gml:id="poly_bottom">
									<gml:exterior>
										<gml:LinearRing>
											<gml:posList>35.0 139.0 0.0 35.0 139.001 0.0 35.001 139.001 0.0 35.001 139.0 0.0 35.0 139.0 0.0</gml:posList>
										</gml:LinearRing>
									</gml:exterior>
								</gml:Polygon>
							</gml:surfaceMember>
							<gml:surfaceMember>
								<gml:Polygon gml:id="poly_top">
									<gml:exterior>
										<gml:LinearRing>
											<gml:posList>35.0 139.0 10.0 35.001 139.0 10.0 35.001 139.001 10.0 35.0 139.001 10.0 35.0 139.0 10.0</gml:posList>
										</gml:LinearRing>
									</gml:exterior>
								</gml:Polygon>
							</gml:surfaceMember>
						</gml:CompositeSurface>
					</gml:exterior>
				</gml:Solid>
			</bldg:lod1Solid>
			<uro:buildingIDAttribute>
				<uro:BuildingIDAttribute>
					<uro:buildingID>13201-bldg-999999</uro:buildingID>
					<uro:branchID>2</uro:branchID>
					<uro:partID>3</uro:partID>
					<uro:prefecture codeSpace="../../codelists/Common_localPublicAuthorities.xml">13</uro:prefecture>
					<uro:city codeSpace="../../codelists/Common_localPublicAuthorities.xml">13201</uro:city>
				</uro:BuildingIDAttribute>
			</uro:buildingIDAttribute>
			<uro:buildingDetailAttribute>
				<uro:BuildingDetailAttribute>
					<uro:serialNumberOfBuildingCertification>CERT-0001</uro:serialNumberOfBuildingCertification>
					<uro:siteArea uom="m2">500.25</uro:siteArea>
					<uro:totalFloorArea uom="m2">1200.5</uro:totalFloorArea>
					<uro:buildingFootprintArea uom="m2">400.75</uro:buildingFootprintArea>
					<uro:buildingRoofEdgeArea uom="m2">420.0</uro:buildingRoofEdgeArea>
					<uro:developmentArea uom="m2">600.0</uro:developmentArea>
					<uro:buildingStructureType codeSpace="../../codelists/BuildingDetailAttribute_buildingStructureType.xml">611</uro:buildingStructureType>
					<uro:buildingStructureOrgType codeSpace="../../codelists/BuildingDetailAttribute_buildingStructureOrgType.xml">1</uro:buildingStructureOrgType>
					<uro:fireproofStructureType codeSpace="../../codelists/BuildingDetailAttribute_fireproofStructureType.xml">1001</uro:fireproofStructureType>
					<uro:implementingBody>Test Body</uro:implementingBody>
					<uro:urbanPlanType codeSpace="../../codelists/Common_urbanPlanType.xml">21</uro:urbanPlanType>
					<uro:areaClassificationType codeSpace="../../codelists/Common_areaClassificationType.xml">22</uro:areaClassificationType>
					<uro:districtsAndZonesType codeSpace="../../codelists/Common_districtsAndZonesType.xml">1</uro:districtsAndZonesType>
					<uro:districtsAndZonesType codeSpace="../../codelists/Common_districtsAndZonesType.xml">7</uro:districtsAndZonesType>
					<uro:landUseType codeSpace="../../codelists/Common_landUseType.xml">201</uro:landUseType>
					<uro:reference>REF-1</uro:reference>
					<uro:majorUsage codeSpace="../../codelists/BuildingDetailAttribute_majorUsage.xml">411</uro:majorUsage>
					<uro:majorUsage2 codeSpace="../../codelists/BuildingDetailAttribute_majorUsage2.xml">412</uro:majorUsage2>
					<uro:orgUsage codeSpace="../../codelists/BuildingDetailAttribute_orgUsage.xml">1</uro:orgUsage>
					<uro:orgUsage2 codeSpace="../../codelists/BuildingDetailAttribute_orgUsage2.xml">2</uro:orgUsage2>
					<uro:detailedUsage codeSpace="../../codelists/BuildingDetailAttribute_detailedUsage.xml">1</uro:detailedUsage>
					<uro:detailedUsage2 codeSpace="../../codelists/BuildingDetailAttribute_detailedUsage2.xml">2</uro:detailedUsage2>
					<uro:detailedUsage3 codeSpace="../../codelists/BuildingDetailAttribute_detailedUsage3.xml">3</uro:detailedUsage3>
					<uro:groundFloorUsage codeSpace="../../codelists/BuildingDetailAttribute_groundFloorUsage.xml">1</uro:groundFloorUsage>
					<uro:secondFloorUsage codeSpace="../../codelists/BuildingDetailAttribute_secondFloorUsage.xml">2</uro:secondFloorUsage>
					<uro:thirdFloorUsage codeSpace="../../codelists/BuildingDetailAttribute_thirdFloorUsage.xml">3</uro:thirdFloorUsage>
					<uro:basementUsage codeSpace="../../codelists/BuildingDetailAttribute_basementUsage.xml">4</uro:basementUsage>
					<uro:basementFirstUsage codeSpace="../../codelists/BuildingDetailAttribute_basementFirstUsage.xml">5</uro:basementFirstUsage>
					<uro:basementSecondUsage codeSpace="../../codelists/BuildingDetailAttribute_basementSecondUsage.xml">6</uro:basementSecondUsage>
					<uro:vacancy codeSpace="../../codelists/BuildingDetailAttribute_vacancy.xml">1</uro:vacancy>
					<uro:buildingCoverageRate>0.6</uro:buildingCoverageRate>
					<uro:floorAreaRate>2.0</uro:floorAreaRate>
					<uro:specifiedBuildingCoverageRate>0.8</uro:specifiedBuildingCoverageRate>
					<uro:specifiedFloorAreaRate>3.0</uro:specifiedFloorAreaRate>
					<uro:standardFloorAreaRate>2.5</uro:standardFloorAreaRate>
					<uro:buildingHeight uom="m">9.5</uro:buildingHeight>
					<uro:eaveHeight uom="m">8.2</uro:eaveHeight>
					<uro:note>note text</uro:note>
					<uro:surveyYear>2021</uro:surveyYear>
				</uro:BuildingDetailAttribute>
			</uro:buildingDetailAttribute>
			<uro:largeCustomerFacilityAttribute>
				<uro:LargeCustomerFacilityAttribute>
					<uro:class codeSpace="../../codelists/LargeCustomerFacilityAttribute_class.xml">1</uro:class>
					<uro:name>Test Mall</uro:name>
					<uro:capacity>1500</uro:capacity>
					<uro:owner>Owner Co.</uro:owner>
					<uro:totalFloorArea uom="m2">25000.0</uro:totalFloorArea>
					<uro:totalStoreFloorArea uom="m2">18000.0</uro:totalStoreFloorArea>
					<uro:inauguralDate>2010-04-01</uro:inauguralDate>
					<uro:keyTenants>Tenant A, Tenant B</uro:keyTenants>
					<uro:availability>true</uro:availability>
					<uro:urbanPlanType codeSpace="../../codelists/Common_urbanPlanType.xml">21</uro:urbanPlanType>
					<uro:areaClassificationType codeSpace="../../codelists/Common_areaClassificationType.xml">22</uro:areaClassificationType>
					<uro:districtsAndZonesType codeSpace="../../codelists/Common_districtsAndZonesType.xml">7</uro:districtsAndZonesType>
					<uro:landUseType codeSpace="../../codelists/Common_landUseType.xml">201</uro:landUseType>
					<uro:reference>REF-2</uro:reference>
					<uro:note>facility note</uro:note>
					<uro:surveyYear>2020</uro:surveyYear>
				</uro:LargeCustomerFacilityAttribute>
			</uro:largeCustomerFacilityAttribute>
			<uro:buildingDisasterRiskAttribute>
				<uro:BuildingRiverFloodingRiskAttribute>
					<uro:description codeSpace="../../codelists/BuildingRiverFloodingRiskAttribute_description.xml">1</uro:description>
					<uro:rank codeSpace="../../codelists/BuildingRiverFloodingRiskAttribute_rank.xml">3</uro:rank>
					<uro:rankOrg codeSpace="../../codelists/BuildingRiverFloodingRiskAttribute_rankOrg.xml">33</uro:rankOrg>
					<uro:depth uom="m">2.5</uro:depth>
					<uro:adminType codeSpace="../../codelists/BuildingRiverFloodingRiskAttribute_adminType.xml">1</uro:adminType>
					<uro:scale codeSpace="../../codelists/BuildingRiverFloodingRiskAttribute_scale.xml">L2</uro:scale>
					<uro:duration uom="hour">48.0</uro:duration>
				</uro:BuildingRiverFloodingRiskAttribute>
			</uro:buildingDisasterRiskAttribute>
			<uro:buildingDisasterRiskAttribute>
				<uro:BuildingTsunamiRiskAttribute>
					<uro:description codeSpace="../../codelists/BuildingTsunamiRiskAttribute_description.xml">1</uro:description>
					<uro:rank codeSpace="../../codelists/BuildingTsunamiRiskAttribute_rank.xml">2</uro:rank>
					<uro:depth uom="m">1.2</uro:depth>
				</uro:BuildingTsunamiRiskAttribute>
			</uro:buildingDisasterRiskAttribute>
			<uro:buildingDisasterRiskAttribute>
				<uro:BuildingInlandFloodingRiskAttribute>
					<uro:description codeSpace="../../codelists/BuildingInlandFloodingRiskAttribute_description.xml">1</uro:description>
					<uro:rankOrg codeSpace="../../codelists/BuildingInlandFloodingRiskAttribute_rankOrg.xml">1</uro:rankOrg>
				</uro:BuildingInlandFloodingRiskAttribute>
			</uro:buildingDisasterRiskAttribute>
			<uro:buildingDisasterRiskAttribute>
				<uro:BuildingHighTideRiskAttribute>
					<uro:description codeSpace="../../codelists/BuildingHighTideRiskAttribute_description.xml">1</uro:description>
					<uro:rank codeSpace="../../codelists/BuildingHighTideRiskAttribute_rank.xml">1</uro:rank>
					<uro:depth uom="m">0.4</uro:depth>
				</uro:BuildingHighTideRiskAttribute>
			</uro:buildingDisasterRiskAttribute>
			<uro:buildingDisasterRiskAttribute>
				<uro:BuildingLandSlideRiskAttribute>
					<uro:description codeSpace="../../codelists/BuildingLandSlideRiskAttribute_description.xml">1</uro:description>
					<uro:areaType codeSpace="../../codelists/BuildingLandSlideRiskAttribute_areaType.xml">2</uro:areaType>
				</uro:BuildingLandSlideRiskAttribute>
			</uro:buildingDisasterRiskAttribute>
			<uro:keyValuePairAttribute>
				<uro:KeyValuePairAttribute>
					<uro:key codeSpace="../../codelists/KeyValuePairAttribute_key.xml">105</uro:key>
					<uro:codeValue codeSpace="../../codelists/KeyValuePairAttribute_key105.xml">1</uro:codeValue>
				</uro:KeyValuePairAttribute>
			</uro:keyValuePairAttribute>
			<uro:keyValuePairAttribute>
				<uro:KeyValuePairAttribute>
					<uro:key codeSpace="../../codelists/KeyValuePairAttribute_key.xml">201</uro:key>
					<uro:stringValue>string value</uro:stringValue>
				</uro:KeyValuePairAttribute>
			</uro:keyValuePairAttribute>
			<uro:keyValuePairAttribute>
				<uro:KeyValuePairAttribute>
					<uro:key codeSpace="../../codelists/KeyValuePairAttribute_key.xml">202</uro:key>
					<uro:intValue>42</uro:intValue>
				</uro:KeyValuePairAttribute>
			</uro:keyValuePairAttribute>
			<uro:keyValuePairAttribute>
				<uro:KeyValuePairAttribute>
					<uro:key codeSpace="../../codelists/KeyValuePairAttribute_key.xml">203</uro:key>
					<uro:doubleValue>3.14159</uro:doubleValue>
				</uro:KeyValuePairAttribute>
			</uro:keyValuePairAttribute>
			<uro:keyValuePairAttribute>
				<uro:KeyValuePairAttribute>
					<uro:key codeSpace="../../codelists/KeyValuePairAttribute_key.xml">204</uro:key>
					<uro:measuredValue uom="m">12.5</uro:measuredValue>
				</uro:KeyValuePairAttribute>
			</uro:keyValuePairAttribute>
			<uro:keyValuePairAttribute>
				<uro:KeyValuePairAttribute>
					<uro:key codeSpace="../../codelists/KeyValuePairAttribute_key.xml">205</uro:key>
					<uro:dateValue>2022-07-19</uro:dateValue>
				</uro:KeyValuePairAttribute>
			</uro:keyValuePairAttribute>
			<uro:keyValuePairAttribute>
				<uro:KeyValuePairAttribute>
					<uro:key codeSpace="../../codelists/KeyValuePairAttribute_key.xml">206</uro:key>
					<uro:uriValue>https://example.com/doc</uro:uriValue>
				</uro:KeyValuePairAttribute>
			</uro:keyValuePairAttribute>
			<uro:buildingDataQualityAttribute>
				<uro:BuildingDataQualityAttribute>
					<uro:srcScale codeSpace="../../codelists/BuildingDataQualityAttribute_srcScale.xml">1</uro:srcScale>
					<uro:srcScale codeSpace="../../codelists/BuildingDataQualityAttribute_srcScale.xml">2</uro:srcScale>
					<uro:geometrySrcDesc codeSpace="../../codelists/BuildingDataQualityAttribute_geometrySrcDesc.xml">1</uro:geometrySrcDesc>
					<uro:thematicSrcDesc codeSpace="../../codelists/BuildingDataQualityAttribute_thematicSrcDesc.xml">1</uro:thematicSrcDesc>
					<uro:thematicSrcDesc codeSpace="../../codelists/BuildingDataQualityAttribute_thematicSrcDesc.xml">3</uro:thematicSrcDesc>
					<uro:appearanceSrcDesc codeSpace="../../codelists/BuildingDataQualityAttribute_appearanceSrcDesc.xml">1</uro:appearanceSrcDesc>
					<uro:lod1HeightType codeSpace="../../codelists/BuildingDataQualityAttribute_lod1HeightType.xml">2</uro:lod1HeightType>
					<uro:lodType>2.0</uro:lodType>
					<uro:lodType>3.1</uro:lodType>
				</uro:BuildingDataQualityAttribute>
			</uro:buildingDataQualityAttribute>
		</bldg:Building>
	</core:cityObjectMember>
</core:CityModel>
