<?xml version="1.0" encoding="UTF-8"?>
<!-- Synthetic i-UR 3.1 fixture: one building using every supported uro building attribute field. -->
<core:CityModel xmlns:core="http://www.opengis.net/citygml/2.0" xmlns:bldg="http://www.opengis.net/citygml/building/2.0" xmlns:gml="http://www.opengis.net/gml" xmlns:uro="https://www.geospatial.jp/iur/uro/3.1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="https://www.geospatial.jp/iur/uro/3.1 ../_data/maebashi/urbanObject-3.1.2.xsd http://www.opengis.net/citygml/2.0 http://schemas.opengis.net/citygml/2.0/cityGMLBase.xsd http://www.opengis.net/citygml/building/2.0 http://schemas.opengis.net/citygml/building/2.0/building.xsd">
	<gml:boundedBy>
		<gml:Envelope srsName="http://www.opengis.net/def/crs/EPSG/0/6697" srsDimension="3">
			<gml:lowerCorner>36.0 139.0 0.0</gml:lowerCorner>
			<gml:upperCorner>36.001 139.001 10.0</gml:upperCorner>
		</gml:Envelope>
	</gml:boundedBy>
	<core:cityObjectMember>
		<bldg:Building gml:id="bldg_fixture_all_31">
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
								<gml:Polygon gml:id="poly31_bottom">
									<gml:exterior>
										<gml:LinearRing>
											<gml:posList>36.0 139.0 0.0 36.0 139.001 0.0 36.001 139.001 0.0 36.001 139.0 0.0 36.0 139.0 0.0</gml:posList>
										</gml:LinearRing>
									</gml:exterior>
								</gml:Polygon>
							</gml:surfaceMember>
							<gml:surfaceMember>
								<gml:Polygon gml:id="poly31_top">
									<gml:exterior>
										<gml:LinearRing>
											<gml:posList>36.0 139.0 10.0 36.001 139.0 10.0 36.001 139.001 10.0 36.0 139.001 10.0 36.0 139.0 10.0</gml:posList>
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
					<uro:buildingID>10201-bldg-999999</uro:buildingID>
					<uro:branchID>2</uro:branchID>
					<uro:partID>3</uro:partID>
					<uro:prefecture codeSpace="../../codelists/Common_localPublicAuthorities.xml">10</uro:prefecture>
					<uro:city codeSpace="../../codelists/Common_localPublicAuthorities.xml">10201</uro:city>
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
					<uro:yearOpened>2010</uro:yearOpened>
					<uro:yearClosed>2023</uro:yearClosed>
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
			<uro:bldgDisasterRiskAttribute>
				<uro:RiverFloodingRiskAttribute>
					<uro:description codeSpace="../../codelists/RiverFloodingRiskAttribute_description.xml">1</uro:description>
					<uro:rank codeSpace="../../codelists/RiverFloodingRiskAttribute_rank.xml">3</uro:rank>
					<uro:rankOrg codeSpace="../../codelists/RiverFloodingRiskAttribute_rankOrg.xml">33</uro:rankOrg>
					<uro:depth uom="m">2.5</uro:depth>
					<uro:adminType codeSpace="../../codelists/RiverFloodingRiskAttribute_adminType.xml">1</uro:adminType>
					<uro:scale codeSpace="../../codelists/RiverFloodingRiskAttribute_scale.xml">L2</uro:scale>
					<uro:duration uom="hour">48.0</uro:duration>
				</uro:RiverFloodingRiskAttribute>
			</uro:bldgDisasterRiskAttribute>
			<uro:bldgDisasterRiskAttribute>
				<uro:TsunamiRiskAttribute>
					<uro:description codeSpace="../../codelists/TsunamiRiskAttribute_description.xml">1</uro:description>
					<uro:rank codeSpace="../../codelists/TsunamiRiskAttribute_rank.xml">2</uro:rank>
					<uro:depth uom="m">1.2</uro:depth>
				</uro:TsunamiRiskAttribute>
			</uro:bldgDisasterRiskAttribute>
			<uro:bldgDisasterRiskAttribute>
				<uro:InlandFloodingRiskAttribute>
					<uro:description codeSpace="../../codelists/InlandFloodingRiskAttribute_description.xml">1</uro:description>
					<uro:rankOrg codeSpace="../../codelists/InlandFloodingRiskAttribute_rankOrg.xml">1</uro:rankOrg>
				</uro:InlandFloodingRiskAttribute>
			</uro:bldgDisasterRiskAttribute>
			<uro:bldgDisasterRiskAttribute>
				<uro:HighTideRiskAttribute>
					<uro:description codeSpace="../../codelists/HighTideRiskAttribute_description.xml">1</uro:description>
					<uro:rank codeSpace="../../codelists/HighTideRiskAttribute_rank.xml">1</uro:rank>
					<uro:depth uom="m">0.4</uro:depth>
				</uro:HighTideRiskAttribute>
			</uro:bldgDisasterRiskAttribute>
			<uro:bldgDisasterRiskAttribute>
				<uro:ReservoirFloodingRiskAttribute>
					<uro:description codeSpace="../../codelists/ReservoirFloodingRiskAttribute_description.xml">1</uro:description>
					<uro:rank codeSpace="../../codelists/ReservoirFloodingRiskAttribute_rank.xml">2</uro:rank>
					<uro:depth uom="m">0.9</uro:depth>
				</uro:ReservoirFloodingRiskAttribute>
			</uro:bldgDisasterRiskAttribute>
			<uro:bldgDisasterRiskAttribute>
				<uro:LandSlideRiskAttribute>
					<uro:description codeSpace="../../codelists/LandSlideRiskAttribute_description.xml">1</uro:description>
					<uro:areaType codeSpace="../../codelists/LandSlideRiskAttribute_areaType.xml">2</uro:areaType>
				</uro:LandSlideRiskAttribute>
			</uro:bldgDisasterRiskAttribute>
			<uro:bldgKeyValuePairAttribute>
				<uro:KeyValuePairAttribute>
					<uro:key codeSpace="../../codelists/KeyValuePairAttribute_key.xml">100</uro:key>
					<uro:codeValue codeSpace="../../codelists/KeyValuePairAttribute_key100.xml">3</uro:codeValue>
				</uro:KeyValuePairAttribute>
			</uro:bldgKeyValuePairAttribute>
			<uro:bldgKeyValuePairAttribute>
				<uro:KeyValuePairAttribute>
					<uro:key codeSpace="../../codelists/KeyValuePairAttribute_key.xml">105</uro:key>
					<uro:codeValue codeSpace="../../codelists/KeyValuePairAttribute_key105.xml">1</uro:codeValue>
				</uro:KeyValuePairAttribute>
			</uro:bldgKeyValuePairAttribute>
			<uro:bldgDataQualityAttribute>
				<uro:DataQualityAttribute>
					<uro:geometrySrcDescLod0 codeSpace="../../codelists/DataQualityAttribute_geometrySrcDesc.xml">000</uro:geometrySrcDescLod0>
					<uro:geometrySrcDescLod1 codeSpace="../../codelists/DataQualityAttribute_geometrySrcDesc.xml">000</uro:geometrySrcDescLod1>
					<uro:geometrySrcDescLod1 codeSpace="../../codelists/DataQualityAttribute_geometrySrcDesc.xml">100</uro:geometrySrcDescLod1>
					<uro:geometrySrcDescLod2 codeSpace="../../codelists/DataQualityAttribute_geometrySrcDesc.xml">000</uro:geometrySrcDescLod2>
					<uro:geometrySrcDescLod3 codeSpace="../../codelists/DataQualityAttribute_geometrySrcDesc.xml">200</uro:geometrySrcDescLod3>
					<uro:geometrySrcDescLod4 codeSpace="../../codelists/DataQualityAttribute_geometrySrcDesc.xml">300</uro:geometrySrcDescLod4>
					<uro:thematicSrcDesc codeSpace="../../codelists/DataQualityAttribute_thematicSrcDesc.xml">400</uro:thematicSrcDesc>
					<uro:thematicSrcDesc codeSpace="../../codelists/DataQualityAttribute_thematicSrcDesc.xml">000</uro:thematicSrcDesc>
					<uro:appearanceSrcDescLod0 codeSpace="../../codelists/DataQualityAttribute_appearanceSrcDesc.xml">1</uro:appearanceSrcDescLod0>
					<uro:appearanceSrcDescLod1 codeSpace="../../codelists/DataQualityAttribute_appearanceSrcDesc.xml">1</uro:appearanceSrcDescLod1>
					<uro:appearanceSrcDescLod2 codeSpace="../../codelists/DataQualityAttribute_appearanceSrcDesc.xml">1</uro:appearanceSrcDescLod2>
					<uro:appearanceSrcDescLod3 codeSpace="../../codelists/DataQualityAttribute_appearanceSrcDesc.xml">2</uro:appearanceSrcDescLod3>
					<uro:appearanceSrcDescLod4 codeSpace="../../codelists/DataQualityAttribute_appearanceSrcDesc.xml">2</uro:appearanceSrcDescLod4>
					<uro:lodType codeSpace="../../codelists/Building_lodType.xml">2.0</uro:lodType>
					<uro:lodType codeSpace="../../codelists/Building_lodType.xml">3.1</uro:lodType>
					<uro:lod1HeightType codeSpace="../../codelists/DataQualityAttribute_lod1HeightType.xml">2</uro:lod1HeightType>
					<uro:tranDataAcquisition>acquisition note</uro:tranDataAcquisition>
					<uro:publicSurveyDataQualityAttribute>
						<uro:PublicSurveyDataQualityAttribute>
							<uro:srcScaleLod0 codeSpace="../../codelists/PublicSurveyDataQualityAttribute_srcScale.xml">1</uro:srcScaleLod0>
							<uro:srcScaleLod1 codeSpace="../../codelists/PublicSurveyDataQualityAttribute_srcScale.xml">1</uro:srcScaleLod1>
							<uro:srcScaleLod2 codeSpace="../../codelists/PublicSurveyDataQualityAttribute_srcScale.xml">1</uro:srcScaleLod2>
							<uro:srcScaleLod3 codeSpace="../../codelists/PublicSurveyDataQualityAttribute_srcScale.xml">2</uro:srcScaleLod3>
							<uro:srcScaleLod4 codeSpace="../../codelists/PublicSurveyDataQualityAttribute_srcScale.xml">2</uro:srcScaleLod4>
							<uro:publicSurveySrcDescLod0 codeSpace="../../codelists/PublicSurveyDataQualityAttribute_publicSurveySrcDesc.xml">003</uro:publicSurveySrcDescLod0>
							<uro:publicSurveySrcDescLod1 codeSpace="../../codelists/PublicSurveyDataQualityAttribute_publicSurveySrcDesc.xml">003</uro:publicSurveySrcDescLod1>
							<uro:publicSurveySrcDescLod1 codeSpace="../../codelists/PublicSurveyDataQualityAttribute_publicSurveySrcDesc.xml">004</uro:publicSurveySrcDescLod1>
							<uro:publicSurveySrcDescLod2 codeSpace="../../codelists/PublicSurveyDataQualityAttribute_publicSurveySrcDesc.xml">003</uro:publicSurveySrcDescLod2>
							<uro:publicSurveySrcDescLod3 codeSpace="../../codelists/PublicSurveyDataQualityAttribute_publicSurveySrcDesc.xml">005</uro:publicSurveySrcDescLod3>
							<uro:publicSurveySrcDescLod4 codeSpace="../../codelists/PublicSurveyDataQualityAttribute_publicSurveySrcDesc.xml">006</uro:publicSurveySrcDescLod4>
						</uro:PublicSurveyDataQualityAttribute>
					</uro:publicSurveyDataQualityAttribute>
				</uro:DataQualityAttribute>
			</uro:bldgDataQualityAttribute>
			<uro:bldgRealEstateIDAttribute>
				<uro:RealEstateIDAttribute>
					<uro:realEstateIDOfBuilding>1234-5678-9012-3456-0</uro:realEstateIDOfBuilding>
					<uro:numberOfBuildingUnitOwnership>2</uro:numberOfBuildingUnitOwnership>
					<uro:realEstateIDOfBuildingUnitOwnership>1234-5678-9012-3456-1</uro:realEstateIDOfBuildingUnitOwnership>
					<uro:realEstateIDOfBuildingUnitOwnership>1234-5678-9012-3456-2</uro:realEstateIDOfBuildingUnitOwnership>
					<uro:numberOfRealEstateIDOfLand>1</uro:numberOfRealEstateIDOfLand>
					<uro:realEstateIDOfLand>9876-5432-1098-7654-0</uro:realEstateIDOfLand>
					<uro:matchingScore>95</uro:matchingScore>
				</uro:RealEstateIDAttribute>
			</uro:bldgRealEstateIDAttribute>
			<uro:bldgUsecaseAttribute>
				<uro:BuildingUsecaseAttribute>
					<uro:isTemporal codeSpace="../../codelists/BuildingUsecaseAttribute_isTemporal.xml">1</uro:isTemporal>
					<uro:floorHeight uom="m">3.2</uro:floorHeight>
					<uro:isGroundFloorOpen>true</uro:isGroundFloorOpen>
				</uro:BuildingUsecaseAttribute>
			</uro:bldgUsecaseAttribute>
		</bldg:Building>
	</core:cityObjectMember>
</core:CityModel>
