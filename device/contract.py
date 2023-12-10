import os


# contract address
CONTRACT_ADDRESS = os.getenv("CONTRACT_ADDRESS")

# contract abi description of events
CONTRACT_ABI = [
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
