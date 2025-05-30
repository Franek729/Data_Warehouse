from DataGenerator import generate_agent, generate_adjuster, generate_customer, generate_policy, generate_claim, save_snapshot

if __name__ == "__main__":
    customers = generate_customer()
    agents = generate_agent()
    adjusters = generate_adjuster()
    policies, policies_data = generate_policy(customers, agents)
    claims, claims_data = generate_claim(policies, adjusters) 
    save_snapshot("t1",customers,adjusters,agents,policies,policies_data,claims,claims_data)
    customers = generate_customer()
    agents = generate_agent()
    adjusters = generate_adjuster()
    policies, policies_data = generate_policy(customers, agents)
    claims, claims_data = generate_claim(policies, adjusters) 
    save_snapshot("t2",customers,adjusters,agents,policies,policies_data,claims,claims_data)
