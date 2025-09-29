// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Project {
    address public owner;
    uint256 public projectCount;

    struct ProjectDetail {
        uint256 id;
        string name;
        string description;
        address creator;
        bool isActive;
    }

    mapping(uint256 => ProjectDetail) public projects;

    event ProjectCreated(uint256 id, string name, address creator);
    event ProjectUpdated(uint256 id, string name, string description, bool isActive);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    constructor() {
        owner = msg.sender;
        projectCount = 0;
    }

    // Core function 1: Create a new project
    function createProject(string memory _name, string memory _description) public {
        projectCount++;
        projects[projectCount] = ProjectDetail(projectCount, _name, _description, msg.sender, true);
        emit ProjectCreated(projectCount, _name, msg.sender);
    }

    // Core function 2: Update project details (only creator)
    function updateProject(uint256 _id, string memory _name, string memory _description, bool _isActive) public {
        ProjectDetail storage project = projects[_id];
        require(project.creator == msg.sender, "Only project creator can update");
        project.name = _name;
        project.description = _description;
        project.isActive = _isActive;
        emit ProjectUpdated(_id, _name, _description, _isActive);
    }

    // Core function 3: Fetch project details
    function getProject(uint256 _id) public view returns (ProjectDetail memory) {
        return projects[_id];
    }
}
