pragma solidity ^0.6.0;
contract Token {
	uint256 private totalSupply;
	// [Unimplemented feature]
	// - storage update not implemented for array type
	// string public name;
	// string public symbol;

	// [Unimplemented feature]
	// - generateGetter not implemented for mapping type
	mapping(address => uint256) private balances;

	event Transfer(address indexed _from, address indexed _to, uint256 _value);

	// Safemath
	function add(uint256 a, uint256 b) internal pure returns (uint256) {
		uint256 c = a + b;
		require(c >= a, "SafeMath: addition overflow");

		return c;
	}

	function sub(uint256 a, uint256 b) internal pure returns (uint256) {
		require(b <= a, "SafeMath: subtraction overflow");
		uint256 c = a - b;

		return c;
	}

	constructor() public {
		totalSupply = 100000000;
		// name = "ERC20TokenDemo";
		// symbol = "ETD";
		balances[msg.sender] = totalSupply;
	}

	function balanceOf(address account) view public returns (uint256) {
		return balances[account];
	}

	function transfer(address to, uint256 amount) public returns (bool) {
		balances[msg.sender] = sub(balances[msg.sender], amount);
		balances[to] = add(balances[to], amount);
		emit Transfer(msg.sender, to, amount);
		return true;
	}

	fallback () external payable {}
}
