namespace com.sap.realtor;
using { managed, Country, cuid, Currency } from '@sap/cds/common';

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
    key propertyId: Association to one Property;
    status: String;
}

entity PropertyRequets: managed,cuid{
    //requesterId: Association to one User;
    requesterName: String;
    requesterEmail: String(50);
    requeterPhone: String(15);
    propertyId: Association to one Property;
    requestStatus: Boolean;
}