import axios from "axios";
import todo from "./data/data";

export const findPrimes = (maxNum) => {
  const primes = [];
  for (let i = 1; i <= maxNum; i++) {
    if (isPrime(i)) {
      primes.push(i);
    }
  }
  return primes;
};

const isPrime = (num) => {
  for (let i = 2; i < num; i++) {
    if (num % i === 0) {
      return false;
    }
  }
  return num > 1;
};

export const transitiveClosure = (graph, V) => {
  var reach = Array.from(Array(V), () => new Array(V));
  var i, j, k;
  for (i = 0; i < V; i++) {
    for (j = 0; j < V; j++) {
      reach[i][j] = graph[i][j];
    }
  }
  for (k = 0; k < V; k++) {
    for (i = 0; i < V; i++) {
      for (j = 0; j < V; j++) {
        reach[i][j] =
          reach[i][j] != 0 || (reach[i][k] != 0 && reach[k][j] != 0) ? 1 : 0;
      }
    }
  }
};

export const networkTest = (num) => {
  const requests = [];
  for (let i = 0; i < num; i++) {
    const batch = [
      axios.get("http://10.0.0.160:5000/todos/1"),
      axios.post("http://10.0.0.160:5000/todos", todo),
      axios.delete("http://10.0.0.160:5000/todos/1"),
      axios.patch("http://10.0.0.160:5000/todos/1", todo),
    ];
    requests.push(...batch);
  }

  return requests;
};
