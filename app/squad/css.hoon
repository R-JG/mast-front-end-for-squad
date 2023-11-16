^~
'''
body { 
  box-sizing: border-box;
  padding: 4rem;
  margin: 0;
  overflow: auto;
  display: flex; 
  flex-direction: column;
  justify-content: center; 
  align-items: center; 
  font-family: "Inter", sans-serif;
}
main {
  width: 100%;
  padding-top: 3rem;
  display: flex;
  flex-direction: row;
  justify-content: space-evenly;
  align-items: flex-start;
}
p {
  margin: 0
}
button {
  border: none;
  outline: none;
  border-radius: 2rem; 
  font-weight: 500;
  font-size: 1rem;
  padding: 0.7rem;
  margin-block: 0;
  margin-inline: 0.5rem;
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
code, .code {
  font-family: "Source Code Pro", monospace;
}
.inline {
  display: inline;
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
input {
  border: 1px solid #ccc;
  border-radius: 6px;
  padding: 12px;
  font-size: 12px;
  font-weight: 600;
  min-width: 13rem;
}
.forms-section {
  padding-inline: 2rem;
  padding-bottom: 2rem;
  padding-top: 1rem;
  min-width: 20rem;
  border: 1px solid #ccc;
}
.new-component-checkbox {
  margin-block: 1rem;
}
.join-component {
  display: flex;
}
#is-public-checkbox {
  min-width: 0;
}
.status-modal {
  position: absolute;
  top: 5vh;
  right: 1vw;
  font-size: 0.9rem;
  background-color: #F4F3F1;
  padding: 1rem;
  margin: 1rem;
  border-radius: 1rem;
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  align-items: center;
  box-shadow: rgba(0, 0, 0, 0.15) 0px 3px 6px;
}
.status-modal button {
  background-color: #4eae75;
  color: white;
  padding-inline: 0.5rem;
  padding-block: 0.2rem;
  font-size: 1.2rem;
  margin-left: 1rem;
}
.squads-section-null {
  display: none;
}
.squads-heading {
  margin-top: 0;
  margin-bottom: 1rem;
}
.squad-summary {
  min-width: 20rem;
  border: 1px solid #ccc;
  padding-inline: 2rem;
  padding-block: 1rem;
  margin-bottom: 1rem;
  cursor: pointer;
  transition: transform .1s ease;
}
.squad-summary:hover {
  transform: scale(1.02);
}
.squad-summary-selected {
  border: 1px solid #ccc;
  padding-inline: 2rem;
  padding-block: 1rem;
  min-width: 20rem;
}
.squad-content {
  border-bottom: 1px solid #ccc;
  border-inline: 1px solid #ccc;
  padding: 1rem;
  margin-bottom: 1rem;
}
.squad-content button, .squad-content summary {
  margin-block: 0.5rem;
}
@media only screen and (max-width: 767px)  {
  main {
    flex-direction: column;
  }
  .squads-heading {
    margin-top: 
  }
}
'''