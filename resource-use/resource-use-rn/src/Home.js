import React from 'react';
import {View, Button} from 'react-native';
import {findPrimes, networkTest, transitiveClosure} from './tests';

const Home = () => {
  const handleTestA = () => {
    const startTime = Date.now();
    const primes = findPrimes(300000);
    const endTime = Date.now();
    console.log('test A finished', endTime - startTime);
  };

  const handleTestB = () => {
    const startTime = Date.now();
    const min = 0;
    const max = 1;
    const n = 400;
    const m = 200000;
    const graph = [];
    for (let i = 0; i < m; i++) {
      const v = [];
      for (let j = 0; j < n; j++) {
        const randomNum = Math.floor(Math.random() * (max - min + 1) + min);
        v.push(randomNum);
      }
      graph.push(v);
    }

    transitiveClosure(graph, n);
    const endTime = Date.now();
    console.log('test B finished', endTime - startTime);
  };

  const handleTestC = async () => {
    const startTime = Date.now();
    try {
      const results = await Promise.all(networkTest(500));
    } catch (error) {
      console.log('test C failed', error);
    }
    const endTime = Date.now();
    console.log('test C finished', endTime - startTime);
  };

  return (
    <View style={styles.container}>
      <Button style={styles.buttonStyle} title="Test A" onPress={handleTestA} />
      <Button style={styles.buttonStyle} title="Test B" onPress={handleTestB} />
      <Button style={styles.buttonStyle} title="Test C" onPress={handleTestC} />
    </View>
  );
};

const styles = {
  container: {flex: 1, alignItems: 'center', justifyContent: 'center'},
  buttonStyle: {marginTop: 20},
};

export default Home;
