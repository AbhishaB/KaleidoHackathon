pragma solidity ^0.4.17;

// Declare a contract
contract govtcontract {

   // variable for storing total, remaining budgets and whitelist
    uint256 public allocbudget;
    uint256 public rembudget;
    mapping (string=> bool) whitelist;

    struct transaction{
        uint expend;
        uint dept;
        string purpose;
        string date;
        string time;
        uint location;
    }

    transaction public trx;

    constructor(uint256 initbudget) public {
        allocbudget = initbudget;
        rembudget = initbudget;
        whitelist["BuildingMaterial"]=true;
        whitelist["Labourers"]=true;
        whitelist["ConstructionManager"]=true;
        whitelist["PowerTools"]=true;
    }

    event NoBudget(uint amount, uint remainingBudget);

    event UnauthorizedSpending(string item, uint amount);

   // Sets the value of the variables in the structure transaction
   // Checks if the amount being spent is less than the remaining budget
   // Checks if the purpose of expenditure is authorized
    function set(uint amt, uint dep, string item, string date, string time, uint location) public {
        trx.expend=amt;
        trx.dept=dep;
        trx.purpose=item;
        trx.date=date;
        trx.time=time;
        trx.location=location;
        if (trx.expend <= rembudget) {
            if(whitelist[item]){
                rembudget = rembudget - trx.expend;
            }
            else{
                emit UnauthorizedSpending(trx.purpose, trx.expend);
            }
        }
        else {
            emit NoBudget(amt, rembudget);
        }
    }

   // Gets the value of the remaining budget
    function get() public constant returns (uint retVal) {
        return rembudget;
    }
}
