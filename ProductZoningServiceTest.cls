@isTest
public class ProductZoningServiceTest {
    
    @TestSetup
    static void setup() {
        // Load custom metadata records from static resource
        List<Product_Geo_Mapping__mdt> geoMappings = Test.loadData(Product_Geo_Mapping__mdt.sObjectType, 'ProductGeoMappingMockData');
        // The custom metadata records are now created in a separate transaction.
    }

    @isTest
    static void testGetFlyZone_US() {
        // Create test data
        Product2 prod = new Product2(Name = 'Multi-Rotor Tester', ProductCode = 'TEST123', Family = 'Multi-Rotor');
        insert prod;

        // Load custom metadata records from static resource
        //List<Product_Geo_Mapping__mdt> geoMappings = Test.loadData(Product_Geo_Mapping__mdt.sObjectType, 'ProductGeoMappingMockData');

        // Set the RestContext for testing
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/ProductZoning/';
        req.addParameter('ProductCode', 'TEST123');
        req.headers.put('CountryCode', 'US');
        RestContext.request = req;

        RestResponse res = new RestResponse();
        RestContext.response = res;

        // Call the method
        String response = ProductZoningService.getFlyZone();

        // Verify the response
        System.assertEquals('Recommended', response);
    }

    @isTest
    static void testGetFlyZone_AU() {
        // Create test data
        Product2 prod = new Product2(Name = 'Fixed-Wing Tester', ProductCode = 'TEST123', Family = 'Fixed-Wing');
        insert prod;

        // Load custom metadata records from static resource
        //List<Product_Geo_Mapping__mdt> geoMappings = Test.loadData(Product_Geo_Mapping__mdt.sObjectType, 'ProductGeoMappingMockData');

        // Set the RestContext for testing
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/ProductZoning/';
        req.addParameter('ProductCode', 'TEST123');
        req.headers.put('CountryCode', 'AU');
        RestContext.request = req;

        RestResponse res = new RestResponse();
        RestContext.response = res;

        // Call the method
        String response = ProductZoningService.getFlyZone();

        // Verify the response
        System.assertEquals('Authorized', response);
    }

    @isTest
    static void testGetFlyZone_NoProductCode() {
        // Load custom metadata records from static resource
        //List<Product_Geo_Mapping__mdt> geoMappings = Test.loadData(Product_Geo_Mapping__mdt.sObjectType, 'ProductGeoMappingMockData');

        // Set the RestContext for testing
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/ProductZoning/';
        req.headers.put('CountryCode', 'US');
        RestContext.request = req;

        RestResponse res = new RestResponse();
        RestContext.response = res;

        // Call the method
        String response = ProductZoningService.getFlyZone();

        // Verify the response
        System.assertEquals('ProductCode is missing or doesn\'t exist', response);
    }

    @isTest
    static void testGetFlyZone_NoMapping() {
        // Create test data
        Product2 prod = new Product2(Name = 'Single Rotor GenZ', ProductCode = 'TEST123', Family = 'Single-Rotor');
        insert prod;

        // Load custom metadata records from static resource
        //List<Product_Geo_Mapping__mdt> geoMappings = Test.loadData(Product_Geo_Mapping__mdt.sObjectType, 'ProductGeoMappingMockData');

        // Set the RestContext for testing
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/ProductZoning/';
        req.addParameter('ProductCode', 'TEST123');
        req.headers.put('CountryCode', 'US');
        RestContext.request = req;

        RestResponse res = new RestResponse();
        RestContext.response = res;

        // Call the method
        String response = ProductZoningService.getFlyZone();

        // Verify the response
        System.assertEquals('Recommended', response);
    }

    @isTest
    static void testGetFlyZone_DefaultCountry() {
        // Create test data
        Product2 prod = new Product2(Name = 'Hale GenZ', ProductCode = 'TEST123', Family = 'HALE');
        insert prod;

        // Load custom metadata records from static resource
        //List<Product_Geo_Mapping__mdt> geoMappings = Test.loadData(Product_Geo_Mapping__mdt.sObjectType, 'ProductGeoMappingMockData');

        // Set the RestContext for testing
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/ProductZoning/';
        req.addParameter('ProductCode', 'TEST123');
        req.headers.put('CountryCode', 'CA');
        RestContext.request = req;

        RestResponse res = new RestResponse();
        RestContext.response = res;

        // Call the method
        String response = ProductZoningService.getFlyZone();

        // Verify the response
        System.assertEquals('Restricted', response);
    }
    
     @isTest
    static void testGetFlyZone_CountryNotInRequestHeader() {
        // Create test data
        Product2 prod = new Product2(Name = 'Multi-Rotor No Country GenZ', ProductCode = 'TEST123', Family = 'Multi-Rotor');
        insert prod;

        // Load custom metadata records from static resource
        //List<Product_Geo_Mapping__mdt> geoMappings = Test.loadData(Product_Geo_Mapping__mdt.sObjectType, 'ProductGeoMappingMockData');

        // Set the RestContext for testing
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/ProductZoning/';
        req.addParameter('ProductCode', 'TEST123');
        RestContext.request = req;

        RestResponse res = new RestResponse();
        RestContext.response = res;

        // Call the method
        String response = ProductZoningService.getFlyZone();

        // Verify the response
        System.assertEquals('Recommended', response);
    }
}