import os
import time

from web3 import Web3

from contract import CONTRACT_ADDRESS, CONTRACT_ABI
from handlerEvents import handle_closed_event, handle_opened_event


def connect_endpoint():
    endpoint = os.getenv("ENDPOINT")
    web3 = Web3(Web3.WebsocketProvider(endpoint))
    return web3


def listen_to_events():
    while True:
        try:
            web3 = connect_endpoint()
            contract = web3.eth.contract(address=CONTRACT_ADDRESS, abi=CONTRACT_ABI)

            opened_event_filter = contract.events.OpenedEvent.create_filter(fromBlock='latest')
            closed_event_filter = contract.events.ClosedEvent.create_filter(fromBlock='latest')

            print("Listening for events...")

            while True:
                for event in opened_event_filter.get_new_entries():
                    handle_opened_event(event)

                for event in closed_event_filter.get_new_entries():
                    handle_closed_event(event)

                time.sleep(1)

        except (ConnectionError, TimeoutError):
            print("Connection error occurred. Retrying in 5 seconds...")
            time.sleep(5)

        except Exception as e:
            print(f"An error occurred: {e}")
            break

if __name__ == "__main__":
    listen_to_events()
