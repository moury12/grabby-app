flutter precache --force --ios --verbose
#fix the issue for flutter framework not found


hy there i need u to implement cart secting 
 @contextScopeItemMention from here user will add them to cart 
here i give u an post method 
endpoint: /cart/add
body: {
   "branchId": "69abda42ddcc21dbd181cca9",
   "productId": "69d5f112f11015b5775a950a",
   "menuName":  "Cappuccino Deluxe",
   "menuPrice": 50,
   "menuImage": "/images/image/cappuccino.png",
   "quantity": 2,
   "additionalItems": [
     {
       "itemId": "65f2a3b4c5d6e7f8a9b0c1d2",
       "name": "Extra Foam",
       "price": 5,
       "image": "/images/image/foam.png",
       "quantity": 1
    
     }
   ]
 }
here is response : {
    "statusCode": 201,
    "success": true,
    "message": "Item added to cart successfully",
    "data": {
        "_id": "69e83a5b9344e74fc20b65ba",
        "customerId": "69abe179ddcc21dbd181ccce",
        "branchId": "69abda42ddcc21dbd181cca9",
        "items": [
            {
                "customerId": "69abe179ddcc21dbd181ccce",
                "branchId": "69abda42ddcc21dbd181cca9",
                "productId": "69d5f112f11015b5775a950a",
                "menuName": "Cappuccino Deluxe",
                "menuPrice": 50,
                "menuImage": "/images/image/cappuccino.png",
                "quantity": 2,
                "additionalItems": [
                    {
                        "itemId": "65f2a3b4c5d6e7f8a9b0c1d2",
                        "name": "Extra Foam",
                        "price": 5,
                        "image": "/images/image/foam.png",
                        "quantity": 1,
                        "_id": "69e83fb18c954090ad6646f5"
                    }
                ],
                "totalPrice": 105,
                "_id": "69e83fb18c954090ad6646f4",
                "createdAt": "2026-04-22T03:25:37.463Z",
                "updatedAt": "2026-04-22T03:25:37.463Z"
            }
        ],
        "totalItems": 3,
        "totalAmount": 105,
        "createdAt": "2026-04-22T03:02:51.297Z",
        "updatedAt": "2026-04-22T03:25:37.463Z",
        "__v": 20
    }
}

endpoint for fetch cart 
endpoint: /cart/summary?branchId={{branchId}}

@contextScopeItemMention   here u need to show the list of items 
{
    "statusCode": 200,
    "success": true,
    "message": "Cart summary retrieved successfully",
    "data": [
        {
            "branchId": "69abda42ddcc21dbd181cca9",
            "totalItems": 3,
            "totalAmount": 105,
            "items": [
                {
                    "productId": "69d5f112f11015b5775a950a",
                    "menuName": "Cappuccino Deluxe",
                    "quantity": 2,
                    "totalPrice": 105,
                    "additionalItems": [
                        {
                            "itemId": "65f2a3b4c5d6e7f8a9b0c1d2",
                            "name": "Extra Foam",
                            "price": 5,
                            "image": "/images/image/foam.png",
                            "quantity": 1,
                            "_id": "69e9a294c9ceacd1afab75a2"
                        }
                    ]
                }
            ]
        }
    ]
}
here is response .
for update cart amount 
patch method end point : /cart/item/{{cartItemId}}
body: {
  "quantity": 1
}
after update u need to overlap with this response :
{
    "statusCode": 200,
    "success": true,
    "message": "Cart item updated successfully",
    "data": {
        "_id": "69e83a5b9344e74fc20b65ba",
        "customerId": "69abe179ddcc21dbd181ccce",
        "branchId": "69abda42ddcc21dbd181cca9",
        "items": [
            {
                "customerId": "69abe179ddcc21dbd181ccce",
                "branchId": "69abda42ddcc21dbd181cca9",
                "productId": "69d5f112f11015b5775a950a",
                "menuName": "Cappuccino Deluxe",
                "menuPrice": 50,
                "menuImage": "/images/image/cappuccino.png",
                "quantity": 1,
                "additionalItems": [
                    {
                        "itemId": "65f2a3b4c5d6e7f8a9b0c1d2",
                        "name": "Extra Foam",
                        "price": 5,
                        "image": "/images/image/foam.png",
                        "quantity": 2,
                        "_id": "69e83fb18c954090ad6646f5"
                    }
                ],
                "totalPrice": 60,
                "_id": "69e83fb18c954090ad6646f4",
                "createdAt": "2026-04-22T03:25:37.463Z",
                "updatedAt": "2026-04-22T03:27:10.031Z"
            }
        ],
        "totalItems": 2,
        "totalAmount": 60,
        "createdAt": "2026-04-22T03:02:51.297Z",
        "updatedAt": "2026-04-22T03:27:10.031Z",
        "__v": 21
    }
}
for remove cart delete method 

endpoint : /cart/item/{{cartItemId}}
_____________________

u need to maintain my project architecture also define bloc class in route s @contextScopeItemMention 
