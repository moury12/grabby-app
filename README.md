flutter precache --force --ios --verbose
#fix the issue for flutter framework not found
hy there i need u to implement cart secting 
@contextScopeItemMention from here user will add them to cart 
here i give u an post method 
endpoint: /cart/add
body: [{
  "branchId": "{{branchId}}",
  "productId": "69d5f112f11015b5775a950a",
  "productType": "menu",
  "menuName": "Cappuccino Deluxe",
  "menuPrice": 10,
  "menuImage": "/images/image/cappuccino.png",
  "quantity": 2 
},
{
    "branchId": "69abda42ddcc21dbd181cca9",
    "productId": "69d5f112f11015b5775a950a",
    "productType": "additional_item",
    "menuName": "Almond Milk",
    "menuPrice": 4,
    "menuImage": "/images/image/cheese.png",
    "quantity": 9
}]

here is response : {
    "statusCode": 201,
    "success": true,
    "message": "Item added to cart successfully",
    "data": {
        "_id": "69e73867cef2d93df3f17242",
        "customerId": "69d3857a6299e141b7b72f01",
        "branchId": "69abda42ddcc21dbd181cca9",
        "items": [
            {
                "customerId": "69d3857a6299e141b7b72f01",
                "branchId": "69abda42ddcc21dbd181cca9",
                "productId": "69d5f112f11015b5775a950a",
                "productType": "menu",
                "menuName": "Cappuccino Deluxe",
                "menuPrice": 10,
                "menuImage": "/images/image/cappuccino.png",
                "quantity": 2,
                "additionalItems": [],
                "totalPrice": 20,
                "_id": "69e73867cef2d93df3f17244",
                "createdAt": "2026-04-21T08:42:15.632Z",
                "updatedAt": "2026-04-21T08:42:15.632Z"
            },
            {
                "customerId": "69d3857a6299e141b7b72f01",
                "branchId": "69abda42ddcc21dbd181cca9",
                "productId": "69d5f112f11015b5775a950a",
                "productType": "additional_item",
                "menuName": "Almond Milk",
                "menuPrice": 4,
                "menuImage": "/images/image/cheese.png",
                "quantity": 9,
                "additionalItems": [],
                "totalPrice": 36,
                "_id": "69e73867cef2d93df3f17250",
                "createdAt": "2026-04-21T08:42:15.818Z",
                "updatedAt": "2026-04-21T08:42:15.818Z"
            }
        ],
        "totalItems": 11,
        "totalAmount": 56,
        "createdAt": "2026-04-21T08:42:15.571Z",
        "updatedAt": "2026-04-21T08:42:15.819Z",
        "__v": 2
    }
}

endpoint for fetch cart 
endpoint: /cart?branchId={{branchId}}

@contextScopeItemMention  here u need to show the list of items 
{
    "statusCode": 200,
    "success": true,
    "message": "Cart retrieved successfully",
    "data": [
        {
            "_id": "69e73867cef2d93df3f17242",
            "customerId": {
                "_id": "69d3857a6299e141b7b72f01",
                "name": "John Updated",
                "email": "sayor98367@algarr.com"
            },
            "branchId": {
                "_id": "69abda42ddcc21dbd181cca9",
                "branch_name": "Branch 2 - JBR",
                "address": "JBR The Walk, Shop 5"
            },
            "items": [
                {
                    "customerId": "69d3857a6299e141b7b72f01",
                    "branchId": "69abda42ddcc21dbd181cca9",
                    "productId": "69d5f112f11015b5775a950a",
                    "productType": "menu",
                    "menuName": "Cappuccino Deluxe",
                    "menuPrice": 10,
                    "menuImage": "/images/image/cappuccino.png",
                    "quantity": 2,
                    "additionalItems": [],
                    "totalPrice": 20,
                    "_id": "69e73867cef2d93df3f17244",
                    "createdAt": "2026-04-21T08:42:15.632Z",
                    "updatedAt": "2026-04-21T08:42:15.632Z"
                },
                {
                    "customerId": "69d3857a6299e141b7b72f01",
                    "branchId": "69abda42ddcc21dbd181cca9",
                    "productId": "69d5f112f11015b5775a950a",
                    "productType": "additional_item",
                    "menuName": "Almond Milk",
                    "menuPrice": 4,
                    "menuImage": "/images/image/cheese.png",
                    "quantity": 9,
                    "additionalItems": [],
                    "totalPrice": 36,
                    "_id": "69e73867cef2d93df3f17250",
                    "createdAt": "2026-04-21T08:42:15.818Z",
                    "updatedAt": "2026-04-21T08:42:15.818Z"
                }
            ],
            "totalItems": 11,
            "totalAmount": 56,
            "createdAt": "2026-04-21T08:42:15.571Z",
            "updatedAt": "2026-04-21T08:42:15.819Z",
            "__v": 2
        }
    ]
}
here is response u need to show just which product type is menu 
