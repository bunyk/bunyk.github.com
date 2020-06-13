import asyncio
import random
import json

from sanic import Sanic
from sanic.response import json as json_response

app = Sanic()

@app.route('/data/<data:int>')
async def return_data(request, data):
    return json_response(get_data(
        data, int(request.args.get('size', 10))
    ))

async def get_data(data, size):
    # First we wait 1-5 seconds to simulate request to database
    await asyncio.sleep(1 + random.random() * 4)

    # then start random walk from point that equals to data given
    # This is done to be able to distinguish between different graphs
    position = data
    data = []
    for i in range(size):
        position += random.random() - 0.5
        data.append(position)
    # And return the data of that random walk
    return data


@app.websocket('/ws')
async def websocket(request, websocket):
    while True: # Run forever
        data = await websocket.recv() # when receiving request from socket
        
        # start task to handle that, pass it socket
        asyncio.create_task(handle_socket_data(websocket, data)) 

async def handle_socket_data(websocket, data):
    try:
        json_data = json.loads(data)
        data = json_data['data']
        size = json_data.get('size', 10)
        await websocket.send(json.dumps(dict(
            id=json_data['id'],
            data=await get_data(data, size)
        )))
    except Exception as e:
        await websocket.send(json.dumps(dict(
            error=str(e)
        )))
        return


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
