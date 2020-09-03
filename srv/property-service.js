const cds = require('@sap/cds');
const e = require('express');

const { Property,OwnerProperties,PropertyRequests } = cds.entities('com.sap.realtor');
module.exports = cds.service.impl(srv=>{
    //srv.after('READ','Property',_SelectAvailableProperties)
    srv.before('UPDATE','PropertyRequest',_validateUpdateStatus)
    srv.before('CREATE','PropertyRequest',_validatePropertyStatus)
});
async function _validatePropertyStatus(req)
{   const trans = cds.transaction(req);
    //Check if the same property is already requested by the user
    avlPrpReq = await trans.run( SELECT.from(PropertyRequests).where({propertyId_ID:req.data.propertyId_ID})
    .and({createdBy:req.user.id}));

    if(avlPrpReq.length > 0)
    {
        req.error(400,'Property already reaquested by the User');
    }
    //Check if the Property type is U
    propertyStatus = await trans.run( SELECT.distinct.from(OwnerProperties).where({propertyId:req.data.propertyId_ID}))
    if (propertyStatus[0].status!== 'U')
    {  
        req.error(400,'Property cant be requested');

    }
    
}
async function _validateUpdateStatus(req)
{   const trans = cds.transaction(req);

    if (req.data.status == 'F')// Requester cant set final status
    {
        req.error(400,'Invalid Status');
    }
        
}
// async function _SelectAvailableProperties(properties,req)
// {   const trans = cds.transaction(req);
   
//     var propertyIds = [];
//     properties.forEach(element => {
//         propertyIds.push(element.ID);
//     });
//     var updProperties = [];
//     console.debug(">>>",propertyIds);
//     const propertyStatus = await trans.run(SELECT.from(OwnerProperties).where({propertyId: propertyIds}));
//     console.debug(">>>",propertyStatus);
//     for(let i = 0; i < properties.length;i++){
//         if( propertyStatus[i].status == 'U')
//         { 
//             updProperties.push(properties[i]);
//         }

//     }
//     console.debug(">>>",updProperties);
//     properties = updProperties;
   
// //     const properties = await trans.run(SELECT.from('com.sap.realtor.Property as Property',
// //     ['ID','propertyName','propertyType','propertyBhk','propertyCountry_code',
// //     'propertyArea','propertyAddress','PropertyPrice','currency_code'])
// //     .join('com.sap.realtor.OwnerProperties as OwnerProperties')
// //     .on({'Property.ID':{ '=':'OwnerProperties.propertyId' }})
// //     .where({status: 'U'}));
// //     //.where(createdBy = req.user.id)));
// //     // await SELECT
// //     //     .from('com.sap.nestle.scpiforms.Form as Form', ['Form.ID as FormID', 'Form.Context as Context', 'Scenario.ID as ScenarioID', 'Scenario.GDPRConfig as GDPRConfig'])
// //     //     .join('com.sap.nestle.scpiforms.Scenario as Scenario')
// //     //     .on({ 'Form.ScenarioID': { '=': 'Scenario.ID' } })
// //     //     .and({ 'Form.ScenarioVersion': { '=': 'Scenario.Version' } })
// //     //     .where({ GDPRCompliant: true });
// //     console.debug(">>","success");
// //     return properties;

// }
