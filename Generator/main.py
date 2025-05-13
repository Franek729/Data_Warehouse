from DataGenerator import generate_agent, generate_adjuster, generate_customer, generate_policy, generate_claim, save_snapshot

if __name__ == "__main__":
    customers = generate_customer()
    agents = generate_agent()
    adjusters = generate_adjuster()
    policies, policies_data = generate_policy()
    claims, claims_data = generate_claim() 
    save_snapshot("t1",customers,adjusters,agents,policies,policies_data,claims,claims_data)
    customers[0]['city'] = "Gdańsk"
    customers[0]['address'] = "Kwiatowa 12"
    customers1 = generate_customer()
    agents1 = generate_agent()
    adjusters1 = generate_adjuster()
    policies1, policies_data1 = generate_policy()
    claims1, claims_data1 = generate_claim() 
    save_snapshot("t2",customers1,adjusters1,agents1,policies1,policies_data1,claims1,claims_data1)
