^~
'''
body { 
  display: flex; 
  width: 100%; 
  height: 100%; 
  justify-content: center; 
  align-items: center; 
  font-family: "Inter", sans-serif;
  margin: 0;
  -webkit-font-smoothing: antialiased;
}
main {
  width: 100%;
  max-width: 500px;
  border: 1px solid #ccc;
  border-radius: 5px;
  padding: 1rem;
}
button {
  -webkit-appearance: none;
  border: none;
  outline: none;
  border-radius: 100px; 
  font-weight: 500;
  font-size: 1rem;
  padding: 12px 24px;
  cursor: pointer;
}
button:hover {
  opacity: 0.8;
}
button.inactive {
  background-color: #F4F3F1;
  color: #626160;
}
button.active {
  background-color: #000000;
  color: white;
}
a {
  text-decoration: none;
  font-weight: 600;
  color: rgb(0,177,113);
}
a:hover {
  opacity: 0.8;
}
.none {
  display: none;
}
.block {
  display: block;
}
code, .code {
  font-family: "Source Code Pro", monospace;
}
.bg-green {
  background-color: #12AE22;
}
.bg-green-400 {
  background-color: #4eae75;
}
.bg-red {
  background-color: #ff4136;
}
.text-white {
  color: #fff;
}
h3 {
  font-weight: 600;
  font-size: 1rem;
  color: #626160;
}
form {
  display: flex;
  align-items: center;
  justify-content: space-between;
}
form button, button[type="submit"] {
  border-radius: 10px;
}
input {
  border: 1px solid #ccc;
  border-radius: 6px;
  padding: 12px;
  font-size: 12px;
  font-weight: 600;
}
.flex {
  display: flex;
}
.col {
  flex-direction: column;
}
.align-center {
  align-items: center;
}
.justify-between {
  justify-content: space-between;
}
.grow {
  flex-grow: 1;
}
.inline {
  display: inline;
}
@media screen and (max-width: 480px) {
  main {
    padding: 1rem;
  }
}
'''