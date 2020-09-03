const cds = require('@sap/cds');
const e = require('express');
const {Property, OwnerProperties,PropertyRequests} = cds.entities('com.sap.realtor');
module.exports = cds.service.impl(srv=>{
   srv.after('CREATE','Property',_writeOwnerProperty)
   srv.after('UPDATE','PropertyRequest',_updateOwnerPropertyRequest)
   srv.after('UPDATE','OwnerProperty',_updateOwnerProperty)
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
     const propertyRequests = await trans.run( SELECT.from(PropertyRequests).where({propertyId_ID:propertyReq.propertyId_ID})
                                                                           .and({requestStatus:null}));
     if(propertyRequests.length > 0) 
    
     { 
       for(let i=0; i<propertyRequests.length;i++ )
       { 
         var updateRow = await trans.run(UPDATE(PropertyRequests).set({requestStatus :'R'}).where({ID:propertyRequests[i].ID}));
       }
        
    }
  
    }
  
}
async function _updateOwnerProperty(ownproperty,req)
{
    const trans = cds.transaction(req);
    console.debug(">>",ownproperty);
    if (ownproperty.status == 'S' || ownproperty.status == 'R')//Property is sold or rejected 
    {
    
     // Reject all the Property Request for same Property
     const propertyRequests = await trans.run( SELECT.from(PropertyRequests).where({propertyId_ID:ownproperty.propertyId})
                                                                           .and({requestStatus:null}));

     if(propertyRequests.length > 0) 
     {  
        propertyRequests.forEach(element => {
       
        trans.run(UPDATE(PropertyRequests).set({requestStatus :'R'}).where({ID:element.ID}));
        });
     }

     
  
    }
  
}