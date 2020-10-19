import argparse
import random
from environment import TreasureCube
import numpy as np

class QLAgent(object):
    def __init__(self):
        self.action_space = ['left','right','forward','backward','up','down'] # in TreasureCube
        self.Q = np.zeros([4, 4, 4, 6]) # x, y, z, action
        # Hyperparameters
        self.gamma = 0.99
        self.alpha = 0.5
        self.epsilon = 0.01
            
    def take_action(self, state):
        # Explore action space: epsilon = 0.01 means 1% of the time, randomly pick the action from action_space
        if random.uniform(0, 1) < self.epsilon:
            action = random.choice(self.action_space)
        else:
            # Exploit learned values: 99% of the time, look up Q-table with the highest action value for this state
            state = tuple([int(char) for char in list(state)])
            action = self.action_space[np.argmax(self.Q[state])]
        return action

    def train(self, state, action, next_state, reward):
        # convert state into a list of int, append action to list, make into tuple
        state = [int(char) for char in list(state)]
        state.append(self.action_space.index(action))
        state_action = tuple(state)
        
        # retrieve old_value from Q-table
        old_value = self.Q[state_action]
        
        # convert next_state into a list of int, make into tuple
        next_state = tuple([int(char) for char in list(next_state)])
        
        # retrieve next_max from Q-table
        next_max = np.max(self.Q[next_state])
        
        # update new_value according to Q-Learning algorithm
        new_value = (1 - self.alpha) * old_value + self.alpha * (reward + self.gamma * next_max)
        
        # update new_value in Q-table
        self.Q[state_action] = new_value
    
def test_cube(max_episode, max_step):
    env = TreasureCube(max_step=max_step)
    agent = QLAgent()
    
    # For plotting the learning progress
    episode_records = []

    for epsisode_num in range(0, max_episode):
        state = env.reset()
        terminate = False
        t = 0
        episode_reward = 0
        while not terminate:
            action = agent.take_action(state)
            reward, terminate, next_state = env.step(action)
            episode_reward += reward
            # you can comment the following two lines, if the output is too much
            # env.render() # comment
            # print(f'step: {t}, action: {action}, reward: {reward}') # comment
            t += 1
            agent.train(state, action, next_state, reward)
            state = next_state
        print(f'epsisode: {epsisode_num}, total_steps: {t} episode reward: {episode_reward}')
        episode_records.append(episode_reward)
    with np.printoptions(precision=4, suppress=True):
        print(agent.Q) # print Q table with nice format
    import matplotlib.pyplot as plt
    plt.plot(episode_records)
    plt.ylabel('episode rewards')
    plt.xlabel('episode no.')
    plt.show()


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Test')
    parser.add_argument('--max_episode', type=int, default=500)
    parser.add_argument('--max_step', type=int, default=500)
    args = parser.parse_args()

    test_cube(args.max_episode, args.max_step)
