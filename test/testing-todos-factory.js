const TodoFactoryContract = artifacts.require("TodosFactory");

contract("Testing Todo Factory", accounts => {

  it("Creating Todo from Factory", async () => {
    const TodoFactoryInstance = await TodoFactoryContract.new();

    await TodoFactoryInstance.createTodo();

    assert.equal(await TodoFactoryInstance.getTodosLength(), 1, "Data wasnt added to todo.");
  });

});