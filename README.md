need to implement promotion curd operation
for create promotion post method -
end point: /event-offer/create
body: {
"discountName": "Ramadan Deal",
"eventName": "Ramadan 2024",
"startDate": "2026-03-01",
"endDate": "2026-04-10",
"discountType": "percentage",
"discountValue": 15,
"isActive": true,
"appliedOn": "specific", // 'all'(default), 'specific'
"specificItems": ["69c37be09f8ec3460665b54e", "69c37bc19f8ec3460665b545"]
}
response : {
"statusCode": 201,
"success": true,
"message": "Event offer created successfully",
"data": {
"discountName": "Ramadan Deal",
"eventName": "Ramadan 2024",
"startDate": "2026-03-01T00:00:00.000Z",
"endDate": "2026-04-10T00:00:00.000Z",
"appliedOn": "specific",
"specificItems": [
"69c37be09f8ec3460665b54e",
"69c37bc19f8ec3460665b545"
],
"discountType": "percentage",
"discountValue": 15,
"isActive": true,
"shopOwnerId": "69abd78b7cd774b6e0a41acd",
"createdBy": "shop_owner",
"_id": "69c39ce1c26aa16f7b08e2ac",
"createdAt": "2026-03-25T08:29:21.934Z",
"updatedAt": "2026-03-25T08:29:21.934Z",
"__v": 0
}
}
get all promotions -
endpoint : /event-offer/shop?searchTerm=&page=1&limit=10
response : {
"statusCode": 200,
"success": true,
"message": "Event offers fetched successfully",
"meta": {
"page": 1,
"limit": 10,
"total": 4,
"totalPage": 1
},
"data": [
{
"_id": "69c39ce1c26aa16f7b08e2ac",
"discountName": "Ramadan Deal",
"eventName": "Ramadan 2024",
"startDate": "2026-03-01T00:00:00.000Z",
"endDate": "2026-04-10T00:00:00.000Z",
"appliedOn": "specific",
"specificItems": [
{
"_id": "69c37be09f8ec3460665b54e",
"itemName": "Cappuccino Deluxe",
"price": 22
},
{
"_id": "69c37bc19f8ec3460665b545",
"itemName": "Cappuccino",
"price": 18
}
],
"discountType": "percentage",
"discountValue": 15,
"isActive": true,
"shopOwnerId": {
"_id": "69abd78b7cd774b6e0a41acd",
"name": "Updated Shop Owner Name"
},
"createdBy": "shop_owner",
"createdAt": "2026-03-25T08:29:21.934Z",
"updatedAt": "2026-03-25T08:29:21.934Z"
},
{
"_id": "69c39cbac26aa16f7b08e2a2",
"discountName": "Ramadan Deal",
"eventName": "Ramadan 2024",
"startDate": "2026-03-01T00:00:00.000Z",
"endDate": "2026-04-10T00:00:00.000Z",
"appliedOn": "specific",
"specificItems": [
{
"_id": "69c37be09f8ec3460665b54e",
"itemName": "Cappuccino Deluxe",
"price": 22
},
{
"_id": "69c37bc19f8ec3460665b545",
"itemName": "Cappuccino",
"price": 18
}
],
"discountType": "percentage",
"discountValue": 15,
"isActive": true,
"shopOwnerId": {
"_id": "69abd78b7cd774b6e0a41acd",
"name": "Updated Shop Owner Name"
},
"createdBy": "shop_owner",
"createdAt": "2026-03-25T08:28:42.093Z",
"updatedAt": "2026-03-25T08:28:42.093Z"
},
{
"_id": "69c39c57c26aa16f7b08e29c",
"discountName": "Ramadan Deal",
"eventName": "Ramadan 2024",
"startDate": "2026-03-01T00:00:00.000Z",
"endDate": "2026-04-10T00:00:00.000Z",
"appliedOn": "specific",
"specificItems": [
{
"_id": "69c37be09f8ec3460665b54e",
"itemName": "Cappuccino Deluxe",
"price": 22
},
{
"_id": "69c37bc19f8ec3460665b545",
"itemName": "Cappuccino",
"price": 18
}
],
"discountType": "percentage",
"discountValue": 15,
"isActive": true,
"shopOwnerId": {
"_id": "69abd78b7cd774b6e0a41acd",
"name": "Updated Shop Owner Name"
},
"createdBy": "shop_owner",
"createdAt": "2026-03-25T08:27:03.702Z",
"updatedAt": "2026-03-25T08:27:03.702Z"
},
{
"_id": "69c3844b7bede836406f37eb",
"discountName": "Ramadan Deal",
"eventName": "Ramadan 2024",
"startDate": "2024-03-10T00:00:00.000Z",
"endDate": "2024-04-10T00:00:00.000Z",
"appliedOn": "all",
"specificItems": [],
"discountType": "percentage",
"discountValue": 15,
"isActive": false,
"shopOwnerId": {
"_id": "69abd78b7cd774b6e0a41acd",
"name": "Updated Shop Owner Name"
},
"createdBy": "shop_owner",
"createdAt": "2026-03-25T06:44:27.142Z",
"updatedAt": "2026-03-25T07:00:00.344Z"
}
]
}

delete promotion method-
endpoint: /event-offer/shop/{{eventOfferId}}
for update an event patch method :
enpoint : /event-offer/shop/{{eventOfferId}}
body will be same as post method
applied to item dropdown menu will show this menu list
with edit discount bottom sheet discount can be add also edit