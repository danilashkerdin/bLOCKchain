from web3 import Web3
import os

web3 = Web3(Web3.HTTPProvider(os.getenv("ENDPOINT")))

contract_address = os.getenv("CONTRACT_ADDRESS")

contract_abi = [
    {
        'anonymous': False,
        'inputs': [],
        'name': 'OpenedEvent',
        'type': 'event'
    },
    {
        'anonymous': False,
        'inputs': [],
        'name': 'ClosedEvent',
        'type': 'event'
    }
]

contract = web3.eth.contract(address=contract_address, abi=contract_abi)

def handle_opened_event(event):
    print("Блокировка открыта")

def handle_closed_event(event):
    print("Блокировка закрыта")


opened_event_filter = contract.events.OpenedEvent.create_filter(fromBlock='latest')
closed_event_filter = contract.events.ClosedEvent.create_filter(fromBlock='latest')

print("listen...")

while True:
    for event in opened_event_filter.get_new_entries():
        handle_opened_event(event)

    for event in closed_event_filter.get_new_entries():
        handle_closed_event(event)
