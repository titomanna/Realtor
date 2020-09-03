const cds = require('@sap/cds');
const e = require('express');
const {Property, OwnerProperties,PropertyRequests} = cds.entities('com.sap.realtor');
module.exports = cds.service.impl(srv=>{
   srv.after('CREATE','Property',_writeOwnerProperty)
   srv.after('UPDATE','PropertyRequest',_updateOwnerPropertyRequest)
});
async function _writeOwnerProperty(property,req)
{
  const trans = cds.transaction(req);
  await trans.run (INSERT.into(OwnerProperties).columns('propertyId','ownerId_userId','status').rows(
    [ property.ID, property.createdBy,'U' ]
 ));

  console.debug(">>>", "success" );
}
async function _updateOwnerPropertyRequest(propertyReq,req)
{
    const trans = cds.transaction(req);
 
    if (propertyReq.requestStatus == 'F')//Final request is accepted
    {
    const UpdProperty =  await trans.run ( 
     // Update the Property status to S-Sold in OwnerProperty Record 
     UPDATE(OwnerProperties).set({status:'S'}).where({propertyId:propertyReq.propertyId_ID}))
     // Reject all the Property Request for same Property
     const propertyRequets = await trans.run( SELECT.from(PropertyRequests).where({propertyId_ID:propertyReq.propertyId_ID})
                                                                           .and({requestStatus:null}));
     if(propertyRequets.length > 0) 
      console.debug(propertyRequets);
     { propertyRequets.forEach(element => {
        UPDATE(PropertyRequests).set(requestStatus ='R').where({ID:element.ID});
     });

     }
  
    }
  
}