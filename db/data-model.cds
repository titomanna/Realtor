namespace com.sap.realtor;
using { managed, Country, cuid, Currency } from '@sap/cds/common';
@cds.autoexpose
entity Property: managed, cuid{
    //key propertyId:Integer;
    propertyName: String;
    propertyType: String;
    propertyBhk: Integer;
    propertyCountry: Country;
    propertyArea: String;
    propertyAddress: String;
    PropertyPrice: DecimalFloat;
    currency: Currency;
    //ownerId: Association to one User;
}
@cds.autoexpose
entity User: managed {
    key userId: String; 
    userName: String(50);
    userEmail: String(50);
    userPhone: String(15);
    sellerFlag: Boolean;
    buyerFlag: Boolean;
}

entity OwnerProperties: managed {
    key ownerId: Association to one User;
    key propertyId: UUID;
    Property:Association to one Property on Property.ID = propertyId;
    status: String;
}
@cds.autoexpose
entity PropertyRequests: managed,cuid{
    requesterName: String;
    requesterEmail: String(50);
    requeterPhone: String(15);
    propertyId: Association to one Property ;
    requestStatus: String;
}