use cosmwasm_std::{Instantiate2AddressError, StdError};
use cw_utils::ParseReplyError;
use thiserror::Error;

#[derive(Error, Debug)]
pub enum ContractError {
    #[error(transparent)]
    Std(#[from] StdError),

    #[error(transparent)]
    Parse(#[from] ParseReplyError),

    #[error(transparent)]
    Instantiate2(#[from] Instantiate2AddressError),

    #[error(transparent)]
    Handshake(#[from] polytone::handshake::error::HandshakeError),

    #[error("only the contract itself may call this method")]
    NotSelf,
}
