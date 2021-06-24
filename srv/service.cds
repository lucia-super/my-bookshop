////////////////////////////////////////////////////////////////////////////
//
//    Mashing up imported models...
//

using { sap.capire.management as my } from '../db/schema';

service Main {
    entity Products as projection on my.Products;
    entity Categories as projection on my.Categories;
    function TotalStockCount() returns Integer;
}