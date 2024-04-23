// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "./EventContract.sol";

contract EventFactory {
    uint256 eventId;

  mapping(uint256 => address) eventAddresses;
    EventContract[] eventArray;

    function createNewEvent(
        address _organizer,
        string memory _eventName,
        string memory _description,
        string memory _eventAddress,
        uint256 _date,
        uint256 _startTime,
        uint256 _endTime,
        bool _virtualEvent,
        bool _privateEvent
    ) external {
        EventContract newEvent = new EventContract(
            ++eventId,
            _organizer,
            _eventName,
            _description,
            _eventAddress,
            _date,
            _startTime,
            _endTime,
            _virtualEvent,
            _privateEvent
        );

        eventAddresses[eventId] = address(newEvent);
        eventArray.push(newEvent);
        // eventId++;
    }

function cancelEvent(uint256 _eventId) external {
    // EventDetails memory eventDetails = events[_eventId];
    require(_eventId < eventArray.length, "Invalid index");
    eventArray[_eventId] = eventArray[eventArray.length - 1];
    eventArray.pop();

     delete eventAddresses[_eventId];
}



    function getEvent(
        uint256 _eventId
    ) external view returns (EventContract.EventDetails memory) {
        return EventContract(eventAddresses[_eventId]).getEventDetails();
    }
}
