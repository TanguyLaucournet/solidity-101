pragma solidity >=0.4.21 <0.6.0;


import "../exerciceTemplate.sol";

/*
Exercice 10: Analyzing past transactions
In this exercice, you need to:
- Use Etherscan to visualize this contract's transaction history
- Analyze events
- Use a function 
- Your points are credited by the contract
*/

/*
What you need to know to complete this exercice
A) What was included in the previous exercices

*/
contract ex10 is exerciceTemplate {


	mapping(address => uint) private privateValues;
  mapping(address => bool) public exerciceWasStarted;
  uint[20] private randomValuesStore;
  uint public nextValueStoreRank;

  event showPrivateVariableInEvent(uint i, uint myVariable);
  event showUserRank(uint i);

  constructor(address payable _studentsOrganAddres, address payable _teachersOrganAddress, address payable _pointsManagerContractAddress) 
  exerciceTemplate(_studentsOrganAddres, _teachersOrganAddress, _pointsManagerContractAddress) 
  public
  {}
  
  function setRandomValueStore(uint[20] memory _randomValuesStore) 
  public 
  onlyTeacher
  {
   randomValuesStore = _randomValuesStore;
   nextValueStoreRank = 0;
   for (uint i = 0; i < randomValuesStore.length; i++)
   {
   	emit showPrivateVariableInEvent(i, randomValuesStore[i]+i);
   }
  }

  function startExercice() 
  public 
  canWorkOnExercice 
  {
    privateValues[msg.sender] = randomValuesStore[nextValueStoreRank];
    emit showUserRank(nextValueStoreRank);
    nextValueStoreRank += 1;
    if (nextValueStoreRank >= randomValuesStore.length)
    {
     nextValueStoreRank = 0; 
    }
    exerciceWasStarted[msg.sender] = true;
  }

  function showYouKnowPrivateValue(uint _privateValue) 
  public 
  canWorkOnExercice 
  {
    require(privateValues[msg.sender] == _privateValue);
    require(exerciceWasStarted[msg.sender] == true);
    
    // Validating exercice
    validateExercice(msg.sender);
    creditStudent(200, msg.sender);

  }


}
