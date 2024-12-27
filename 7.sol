// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Abstract contract Employee
abstract contract Employee {
    uint256 public idNumber;   // Public variable for employee ID
    uint256 public managerId;  // Public variable for manager ID

    // Constructor to initialize idNumber and managerId
    constructor(uint256 _idNumber, uint256 _managerId) {
        idNumber = _idNumber;
        managerId = _managerId;
    }

    // Virtual function to get annual cost
    function getAnnualCost() public view virtual returns (uint256);
}

// Contract Salaried inheriting from Employee
contract Salaried is Employee {
    uint256 public annualSalary; // Public variable for annual salary

    // Constructor to initialize idNumber, managerId, and annualSalary
    constructor(uint256 _idNumber, uint256 _managerId, uint256 _annualSalary) 
        Employee(_idNumber, _managerId) {
        annualSalary = _annualSalary;
    }

    // Override function to return annual salary
    function getAnnualCost() public view override returns (uint256) {
        return annualSalary;
    }
}

// Contract Hourly inheriting from Employee
contract Hourly is Employee {
    uint256 public hourlyRate; // Public variable for hourly rate

    // Constructor to initialize idNumber, managerId, and hourlyRate
    constructor(uint256 _idNumber, uint256 _managerId, uint256 _hourlyRate) 
        Employee(_idNumber, _managerId) {
        hourlyRate = _hourlyRate;
    }

    // Function to get annual cost for hourly employee
    function getAnnualCost() public view override returns (uint256) {
        return hourlyRate * 2080; // 2080 hours in a year
    }
}

// Contract Manager
contract Manager {
    uint256[] public employeeIds; // Public array to store employee IDs

    // Function to add employee ID to reports
    function addReport(uint256 _id) public {
        employeeIds.push(_id);
    }

    // Function to reset reports
    function resetReports() public {
        delete employeeIds; // Resets the array to empty
    }
}

// Contract Salesperson inheriting from Hourly
contract Salesperson is Hourly {
    constructor(uint256 _idNumber, uint256 _managerId, uint256 _hourlyRate) 
        Hourly(_idNumber, _managerId, _hourlyRate) {}
}

// Contract EngineeringManager inheriting from Salaried and Manager
contract EngineeringManager is Salaried, Manager {
    constructor(uint256 _idNumber, uint256 _managerId, uint256 _annualSalary) 
        Salaried(_idNumber, _managerId, _annualSalary) {}
}

// Contract for deployment
contract InheritanceSubmission {
    address public salesPerson;         // Public variable for Salesperson address
    address public engineeringManager;  // Public variable for EngineeringManager address

    constructor(address _salesPerson, address _engineeringManager) {
        salesPerson = _salesPerson;
        engineeringManager = _engineeringManager;
    }
}